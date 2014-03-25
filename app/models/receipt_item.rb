class ReceiptItem < ActiveRecord::Base
  belongs_to :receipt
  belongs_to :store_item

  validates :price, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000000 }, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000000 }
  validate :store_item_id_not_changed

  private
  def store_item_id_not_changed
    if self.store_item_id_changed? && self.persisted?
      errors.add(:store_item_id, "Change of receipt_item.store_item_id not allowed!")
    end
  end


end
