class Receipt < ActiveRecord::Base
  # TODO: Make sure a receipt NEVER has multiple of the same store item.
  belongs_to :store
  belongs_to :user
  has_many :receipt_items, dependent: :destroy
  validates :total, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000000}
  validates :notes, length: { maximum: 2000 }

  def find_store_item(store_item)
    # Given a store_item it looks through the receipt for a receipt_item that has
    # the given store_item, or else it returns nil.
    if store_item.nil?
      return nil
    end

    receipt_items = self.receipt_items
    found_item = nil

    receipt_items.each do |item| 
      if item.store_item.name == store_item.name 
        found_item = item
      end
    end

    found_item
  end

  def update_quantity_and_price(store_items, items_to_update, new_receipt_items, params)
    store_items.each do |store_item|
      same_receipt_item = self.find_store_item(store_item)
      if same_receipt_item
        same_receipt_item.quantity += params["quantity_item_#{store_item.id}"].to_f

        same_receipt_item.save!
        items_to_update.append({item_id: same_receipt_item.id, quantity: same_receipt_item.quantity})
      else
        @new_receipt_item = ReceiptItem.new(quantity: params["quantity_item_#{store_item.id}"], 
                                            price: params["store_item_price_#{store_item.id}"], 
                                            store_item: store_item,
                                            receipt: @receipt)

        if @new_receipt_item.valid?
          new_receipt_items.push(@new_receipt_item) 
        else
          return false
        end
      end
    end
  end

end
