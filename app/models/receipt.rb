class Receipt < ActiveRecord::Base
  belongs_to :store
  belongs_to :user
  has_many :item
end
