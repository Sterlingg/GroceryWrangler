class Receipt < ActiveRecord::Base
  belongs_to :store
  belongs_to :user
  has_many :items, dependent: :destroy
  validates :total, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000000}
  validates :notes, length: { maximum: 2000 }
end
