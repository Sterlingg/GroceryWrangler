class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.date :date_purchased
      t.text :notes
      t.float :total
      t.references :store, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
