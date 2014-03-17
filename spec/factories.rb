require 'faker'

FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| Faker::Commerce.department + n.to_s}
  end

  factory :receipt_item do
    price 8.95
    quantity Faker::Number.number(2)
    store_item
  end

  factory :store_item do
    sequence(:name) { |n| Faker::Commerce.product_name + n.to_s}
    description Faker::Lorem.paragraph
    upc Faker::Number.number(12)
    price 8.95
    weight 0.500
    volume 0.0
    category
    store
  end

  factory :store do
  sequence(:name) { |n| Faker::Company.name + n.to_s}
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
    sequence(:name) { |n| Faker::Internet.user_name + n.to_s }
    sequence(:email) { |n| n.to_s + Faker::Internet.email }
  end
end
