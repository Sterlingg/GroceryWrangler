class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.text :description
      t.integer :upc
      t.float :price
      t.float :weight
      t.float :volume
      t.references :category, index: true

      t.timestamps
    end
  end
end
