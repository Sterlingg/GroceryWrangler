class Receipt < ActiveRecord::Base
  # TODO: Make sure a receipt NEVER has multiple of the same store item.
  belongs_to :store
  belongs_to :user
  has_many :receipt_items, dependent: :destroy
  validates :total, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000000}
  validates :notes, length: { maximum: 2000 }

  def find_store_item(store_item)
    # Given a store_item it looks through the receipt for a receipt_item that
    # has the given store_item, or else it returns nil.
    if store_item.nil?
      return nil
    end

    self.receipt_items.each do |item| 
      return item if item.store_item.name == store_item.name 
    end

    return false
  end

  def add_items(store_items, params)
    @new_rec_items = []
    @items_to_update = []

    store_items.each do |store_item|
      same_rec_item = self.find_store_item(store_item)

      if same_rec_item
        same_rec_item.update_quantity(params["quantity_item_#{store_item.id}"].to_f)

        @items_to_update.append({item_id: same_rec_item.id, 
                                 quantity: same_rec_item.quantity})
      else
        @new_rec_item = ReceiptItem.new(quantity: params["quantity_item_#{store_item.id}"], 
                                        price: params["store_item_price_#{store_item.id}"], 
                                        store_item: store_item,
                                        receipt: self)

        if @new_rec_item.valid?
          @new_rec_items.push(@new_rec_item)
        else
          return false
        end
      end
    end

    return {new_rec_items: @new_rec_items, items_to_update: @items_to_update}
  end
end
