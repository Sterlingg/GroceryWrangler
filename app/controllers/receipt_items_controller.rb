class ReceiptItemsController < ApplicationController

  # GET /receipt_items_selection_dialog
  def selection_dialog
    @category = Category.find(params[:category])
    @receipt = Receipt.find(params[:receipt])
    @store_items = @category.store_items
     respond_to do |format|
      format.js 
    end
  end

  # PATCH /receipt_items/#
  def update
    @receipt_item = ReceiptItem.find(params[:receipt_item][:id])
    @old_price = @receipt_item.price
    @old_quantity = @receipt_item.quantity
    
    if @receipt_item.update_attributes(receipt_item_params)
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        #TODO: Error here.
        format.js{head :ok}
      end      
    end
  end

  private 
  def receipt_item_params
    params.require(:receipt_item).permit(:quantity, :price)
  end
end
