class ReceiptItem < ActiveRecord::Base
  belongs_to :receipt
  belongs_to :store_item

  validates :price, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000000 }, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000000 }
end
