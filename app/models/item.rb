class Item < ActiveRecord::Base
  belongs_to :category
  belongs_to :receipt
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000000 }, presence: true
  validates :weight, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000000 }
  validates :volume, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000000 }
end
