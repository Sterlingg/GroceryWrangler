class ModalController < ApplicationController

  # TODO: Make nicer using helper methods.
  def add_items
    @store_items = StoreItem.where(id: params[:item_ids])
    
    @receipt = Receipt.find(params[:receipt])
    @new_receipt_items = []
    
    if @store_items
      @store_items.each do |store_item|

        same_store_item = get_receipt_item(@receipt, store_item)
        if same_store_item
          same_store_item.quantity += params["quantity_item_#{store_item.id}"].to_f
          same_store_item.save
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

      @new_receipt_items.each { |item| item.save }
    end
  end

  def category_selection
    @categories = Category.all()
    @receipt = Receipt.find(params[:receipt])
    respond_to do |format|
      # TODO: Appropriate page for browsers without JS
      format.js 
    end
  end

  def item_selection
    @category = Category.find(params[:category])
    @receipt = Receipt.find(params[:receipt])
    @store_items = @category.store_items
     respond_to do |format|
      # TODO: Appropriate page for browsers without JS\
      format.js 
    end
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
