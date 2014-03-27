class ReceiptsController < ApplicationController

  def add_items
    @store_items = StoreItem.where(id: params[:item_ids])
    
    @receipt = Receipt.find(params[:receipt])
    @new_receipt_items = []
    @items_to_update = []

    if @store_items
      @store_items.each do |store_item|

        same_receipt_item = get_receipt_item(@receipt, store_item)
        if same_receipt_item
          same_receipt_item.quantity += params["quantity_item_#{store_item.id}"].to_f
          same_receipt_item.save
          @items_to_update.append({item_id: same_receipt_item.id, quantity: same_receipt_item.quantity})
        else
          @new_receipt_item = ReceiptItem.new(quantity: params["quantity_item_#{store_item.id}"], price: params["store_item_price_#{store_item.id}"], store_item: store_item, receipt: @receipt)

          if @new_receipt_item.valid?
            @new_receipt_items.push(@new_receipt_item) 
          else
            respond_to do |format|
              format.js { render 'error' and return }
            end
          end
        end
      end

      # This should be safe as the quantity in the database must be a number, and 
      # item_id is gathered from the database itself.
      @items_to_update = @items_to_update.to_json
      @new_receipt_items.each { |item| item.save }
    end
  end

  def index
    @receipts = Receipt.all()
  end

  def show
    @receipt = Receipt.find(params[:id])
    render layout: "receipt"
  end

  private
  def get_receipt_item(receipt, store_item)
    # Given a store_item it looks through the receipt for a receipt_item that has
    # the given store_item, or else it returns nil.
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
end
