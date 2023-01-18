class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.integer :account_no
      t.string :account_type
      t.decimal :total_balance

      t.timestamps
    end

    add_reference :accounts, :user, foreign_key: true
    add_reference :accounts, :branch, foreign_key: true
  end
end
