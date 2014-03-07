class Store < ActiveRecord::Base
  has_many :receipts, dependent: :destroy
  validates :name, presence: true, length: {maximum: 50}
end
