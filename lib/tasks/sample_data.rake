namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    10.times do |n|
      Store.create!(name: Faker::Company.name) 
    end

    stores = Store.all()
    5.times do
      stores.each { |store| store.receipts.create!(date_purchased: rand(10.years).from_now,
                                                   notes: Faker::Lorem.paragraph,
                                                   total: 8.95) }
    end

    receipts = Receipt.all()
    10.times do
      s_item = StoreItem.create!(name: Faker::Commerce.product_name, 
                                 description: Faker::Lorem.paragraph,
                                 category: Category.create!(name: Faker::Commerce.department),
                        upc: Faker::Number.number(12), price: 8.95, weight: 0.100, volume: 0.0)
      receipts.each { |receipt| receipt.receipt_items.create!(store_item: s_item,
                                                              quantity: Faker::Number.number(2),
                                                              price: 8.95
                                                              ) }
    end
  end
end
