class CreateStoreItems < ActiveRecord::Migration
  def change
    create_table :store_items do |t|
      t.text :description
      t.integer :upc
      t.float :price
      t.float :weight
      t.float :volume
      t.string :name
      t.references :category, index: true
      t.references :store, index: true

      t.timestamps
    end
  end
end
