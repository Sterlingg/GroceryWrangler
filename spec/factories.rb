require 'faker'

FactoryGirl.define do
  factory :category do
    name     "PoTayToes"
  end

  factory :item do
    name "Spaghetti"
    description Faker::Lorem.paragraph
    upc Faker::Number.number(12)
    price 8.95
    weight 0.500
    volume 0.0
    category
    receipt
  end

  factory :store do
    name     Faker::Company.name
  end

  factory :receipt do
    date_purchased 1.year.from_now
    notes Faker::Lorem.paragraph
    total 123.45
    store
    user
  end

  factory :user do
    name     Faker::Internet.user_name
    email    Faker::Internet.email
  end

end
