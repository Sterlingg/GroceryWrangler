class StoreItem < ActiveRecord::Base
  belongs_to :category
  belongs_to :store
  has_many :receipt_items, dependent: :destroy

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000000 }, presence: true
  validates :weight, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000000 }
  validates :volume, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000000 }
end
