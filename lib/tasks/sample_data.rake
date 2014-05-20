namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    10.times do |n|
      FactoryGirl.create(:store)
    end

    stores = Store.all()
    5.times do
      stores.each { |store| store.receipts.create!(date_purchased: rand(10.years).from_now,
                                                   notes: Faker::Lorem.paragraph,
                                                   total: 8.95, user: FactoryGirl.create(:user)) }
    end

    10.times do |n|
      FactoryGirl.create(:category)
    end

    receipts = Receipt.all()
    categories = Category.all()

    # Add 1 store item for each category and add 10 store items to each receipt.
    10.times do |n|
      s_item = StoreItem.create!(name: Faker::Commerce.product_name + n.to_s, 
                                 description: Faker::Lorem.paragraph,
                                 category: categories[n],
				 store: stores.sample,
				 upc: Faker::Number.number(12), price: 8.95, weight: 0.100, volume: 0.0)

    end

    store_items = StoreItem.all()
    10.times do |n|
      receipts.each { |receipt| receipt.receipt_items.create!(store_item: store_items.sample,
                                                              quantity: Faker::Number.number(2),
                                                              price: 8.95
                                                              ) }
    end


    
    # add 5 items to each category
    categories.each do |cat|
      5.times do |n|
        cat.store_items << StoreItem.create!(name: Faker::Commerce.product_name + n.to_s + 10.to_s, 
                                 description: Faker::Lorem.paragraph,
                                 category: categories[n],
                        upc: Faker::Number.number(12), price: 8.95, weight: 0.100, volume: 0.0)
      end
      cat.save
    end

    


  end
end
