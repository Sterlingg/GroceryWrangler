require 'faker'

FactoryGirl.define do
  MAX_STORE_ITEM_NAME_LENGTH = 100
  MAX_STORE_NAME_LENGTH = 50
  MAX_CATEGORY_NAME_LENGTH = 50
  MAX_USER_NAME_LENGTH = 50

  factory :category do
    sequence(:name) do |n| 
      category_name = Faker::Commerce.department[0..MAX_CATEGORY_NAME_LENGTH - 1]
      category_name[0.. category_name.length - n.to_s.length - 1] + n.to_s
    end
  end

  factory :receipt_item do
    price 8.95
    quantity Faker::Number.number(2)
    store_item
  end

  factory :store_item do
    sequence(:name) do |n| 
      product_name = Faker::Commerce.product_name[0..MAX_STORE_ITEM_NAME_LENGTH - 1]
      product_name[0.. product_name.length - n.to_s.length - 1] + n.to_s
    end
    description Faker::Lorem.paragraph
    upc Faker::Number.number(12)
    price 8.95
    weight 0.500
    volume 0.0
    factory :store_item_full do
      category
      store
    end
  end

  factory :store do
    sequence(:name) do |n| 
      store_name = Faker::Company.name[0..MAX_STORE_NAME_LENGTH - 1]
      store_name[0.. store_name.length - n.to_s.length - 1] + n.to_s
    end
  end

  factory :receipt do
    date_purchased 1.year.from_now
    notes Faker::Lorem.paragraph
    total 123.45
    store
    user

    factory :receipt_with_items do

      ignore do
        item_count 5
      end

      after(:create) do |receipt, evaluator|
        create_list(:receipt_item, evaluator.item_count, receipt: receipt)
      end
    end
  end

  factory :user do
    sequence(:name) do |n| 
      user_name = Faker::Internet.user_name[0..MAX_USER_NAME_LENGTH - 1]
      user_name[0.. user_name.length - n.to_s.length - 1] + n.to_s
    end
    
    password 'password'
    password_confirmation 'password'
    sequence(:email) { |n| n.to_s + Faker::Internet.email }
  end
end
