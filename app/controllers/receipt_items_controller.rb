class ReceiptItemsController < ApplicationController
  
  # PUT
  def edit
    
  end
  
  # GET /receipt_items_selection_dialog
  def selection_dialog
    @category = Category.find(params[:category])
    @receipt = Receipt.find(params[:receipt])
    @store_items = @category.store_items
     respond_to do |format|
      # TODO: Appropriate page for browsers without JS\
      format.js 
    end
  end

end
