class CreateReceiptItems < ActiveRecord::Migration
  def change
    create_table :receipt_items do |t|

      t.float :quantity
      t.float :price

      t.references :store_item, index: true
      t.references :receipt, index: true
    end
  end
end
