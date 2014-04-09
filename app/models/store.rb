class Store < ActiveRecord::Base
  has_many :receipts, dependent: :destroy
  validates :name, presence: true, length: {maximum: 50}

  def store_name
    "#{name}"
  end

end
