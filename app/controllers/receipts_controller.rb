class ReceiptsController < ApplicationController
  before_action :signed_in_user, only: [:add_items, :index, :new, :show]

  # POST /receipt_add_items
  def add_items
    @store_items = StoreItem.where(id: params[:item_ids])
    
    @receipt = Receipt.find(params[:receipt])
    @new_receipt_items = []
    @items_to_update = []

    unless @receipt.update_quantity_and_price(@store_items, @items_to_update, @new_receipt_items, params)
        respond_to do |format|
        format.js { render 'error' and return }
      end
    end

    # This should be safe as the quantity in the database must be a number, and 
    # item_id is gathered from the database itself.
    @items_to_update = @items_to_update.to_json.html_safe
    @new_receipt_items.each {|item| item.save}
    @receipt.reload
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

    if current_users_receipt?(@receipt)
      render layout: "receipt"
    else
      flash[:errors] = "This is not your receipt!"
      redirect_to root_url
    end
  end

  private
  def current_users_receipt?(receipt)
    current_user && current_user.id == receipt.user.id
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
