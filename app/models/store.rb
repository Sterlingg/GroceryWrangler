class Store < ActiveRecord::Base
  has_many :receipts
  validates :name, presence: true, length: {maximum: 50}
end
