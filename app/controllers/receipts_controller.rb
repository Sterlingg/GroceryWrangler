class ReceiptsController < ApplicationController
  before_action :signed_in_user, only: [:add_items, :index, :new, :show]
  DEFAULT_TOTAL = 0

  # POST /receipt_add_items
  def add_items
    @store_items = StoreItem.where(id: params[:item_ids])
    
    @receipt = Receipt.find(params[:receipt])
    @new_receipt_items = []
    @items_to_update = []
    
    @total_added = 0

    @store_items.each do |store_item|
      same_receipt_item = get_receipt_item(@receipt, store_item)
      if same_receipt_item
        same_receipt_item.quantity += params["quantity_item_#{store_item.id}"].to_f
        @total_added += params["quantity_item_#{store_item.id}"].to_f * same_receipt_item.price
        same_receipt_item.save
        @items_to_update.append({item_id: same_receipt_item.id, quantity: same_receipt_item.quantity})
      else
        @new_receipt_item = ReceiptItem.new(quantity: params["quantity_item_#{store_item.id}"], price: params["store_item_price_#{store_item.id}"], store_item: store_item, receipt: @receipt)

        if @new_receipt_item.valid?
          @new_receipt_items.push(@new_receipt_item) 
          @total_added += @new_receipt_item.price * @new_receipt_item.quantity
        else
          respond_to do |format|
            format.js { render 'error' and return }
          end
        end
      end


      # This should be safe as the quantity in the database must be a number, and 
      # item_id is gathered from the database itself.
      @items_to_update = @items_to_update.to_json
      @new_receipt_items.each { |item| item.save }
    end
  end

  # POST /receipts
  def create
    @receipt = Receipt.new(receipt_params)
    @receipt.user_id = current_user.id
    if @receipt.save
      flash[:success] = "Receipt created!"
      redirect_to @receipt
    else
      @errors = @receipt.errors
      render 'new'
    end    
  end

  # DELETE /receipt/#
  def destroy 
    @receipt = Receipt.find(params[:id])
    @receipt.destroy
    redirect_to receipts_url
  end

  # GET /receipts
  def index
    @receipts = Receipt.where(user_id: current_user.id)
    render layout: "receipt"
  end

  # GET /receipts/new
  def new
    @receipt = Receipt.new
  end

  # GET /receipt/#
  def show
    @receipt = Receipt.find(params[:id])

    if current_user && current_user.id == @receipt.user.id
      render layout: "receipt"
    else
      flash[:errors] = "This is not your receipt!"
      redirect_to root_url
    end
  end

  private
  # Given a store_item it looks through the receipt for a receipt_item that has
  # the given store_item, or else it returns nil.
  def get_receipt_item(receipt, store_item)
    if receipt.nil? or store_item.nil?
      return nil
    end

    receipt_items = receipt.receipt_items
    found_item = nil

    receipt_items.each do |item| 
      if item.store_item.name == store_item.name 
        found_item = item
      end
    end

    return found_item
  end

  def receipt_params
    params.require(:receipt).permit(:notes, :date_purchased, :store_id)
  end

  # Before filters
  def signed_in_user
    unless signed_in?
      flash[:errors] = "Please sign in."
      redirect_to root_url
    end
  end
end
