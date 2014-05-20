class ReceiptItem < ActiveRecord::Base
  before_save :update_total
  before_destroy :total_after_removal

  belongs_to :receipt
  belongs_to :store_item

  validates :price, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000000 }, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000000 }
  validate :store_item_id_not_changed

  private
  def total_after_removal
    @receipt = Receipt.find_by_id(self.receipt_id)

    if @receipt
      @receipt.total -= self.quantity * self.price
      @receipt.save!
    end
  end

  # TODO: BULK UPDATE!
  def update_total
    old_quantity = self.quantity_was || 0.0
    old_price = self.price_was || 0.0
    new_quantity = self.quantity
    new_price = self.price

    @receipt = Receipt.find_by_id(self.receipt_id)
    
    if @receipt
      delta_q = new_quantity - old_quantity
      delta_p = new_price - old_price

      @receipt.total += (old_quantity * delta_p) + delta_q * (old_price + delta_p)
      @receipt.save!
    end
  end

  def store_item_id_not_changed
    if self.store_item_id_changed? && self.persisted?
      errors.add(:store_item_id, "Change of receipt_item.store_item_id not allowed!")
    end
  end
end
