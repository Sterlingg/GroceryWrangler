class AddDefaultTotalToReceipt < ActiveRecord::Migration
  def change
    change_column :receipts, :total, :integer, :default => 0
  end
end
