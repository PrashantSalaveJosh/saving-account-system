class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.integer :account_no
      t.string :account_type
      t.decimal :total_balance
      t.references :user, foreign_key: true
      t.references :branch, foreign_key: true

      t.timestamps
    end
  end
end
