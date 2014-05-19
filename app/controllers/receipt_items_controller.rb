class ReceiptItemsController < ApplicationController

  # DELETE /receipt_items
  def destroy
    @receipt_item = ReceiptItem.find(params[:id])
    @receipt = Receipt.find_by_id(@receipt_item.receipt_id)
    @receipt_item.destroy
    @receipt.reload
  end

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
    @receipt = Receipt.find_by_id(@receipt_item.receipt_id)

    @old_price = @receipt_item.price
    @old_quantity = @receipt_item.quantity
    
    if @receipt_item.update_attributes(receipt_item_params)
      respond_to do |format|
        @receipt.reload
        format.js
      end
    else
      respond_to do |format|
        format.js {head :ok}
      end      
    end
  end

  private 
  def receipt_item_params
    params.require(:receipt_item).permit(:quantity, :price)
  end
end
