class Category < ActiveRecord::Base
  has_many :store_items, dependent: :destroy
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true
end
