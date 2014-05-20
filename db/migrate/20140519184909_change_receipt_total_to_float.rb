class ChangeReceiptTotalToFloat < ActiveRecord::Migration
  def change
    change_column :receipts, :total, :float, :default => 0.0
  end
end
