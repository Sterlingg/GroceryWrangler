namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    10.times do |n|
      Store.create!(name: Faker::Company.name)
    end

    stores = Store.all()
    25.times do
      stores.each { |store| store.receipts.create!(date_purchased: rand(10.years).from_now,
                                                   notes: Faker::Lorem.paragraph,
                                                   total: 8.95) }
    end

    receipts = Receipt.all()
    10.times do
      content = Faker::Lorem.sentence(5)
      receipts.each { |receipt| receipt.items.create!(name: Faker::Company.name,
                                                      description: Faker::Lorem.paragraph,
                                                      upc: Faker::Number.number(12),
                                                      price: 8.95,
                                                      weight: 0.100,
                                                      volume: 0.0) }
    end
  end
end
