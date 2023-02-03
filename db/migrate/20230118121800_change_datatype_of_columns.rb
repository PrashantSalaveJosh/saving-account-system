class ChangeDatatypeOfColumns < ActiveRecord::Migration[7.0]
  def change
    change_column :accounts, :total_balance, :float
    change_column :transactions, :amount, :float
    change_column :transactions, :balance, :float
  end
end
