class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_type
      t.string :details
      t.decimal :amount
      t.decimal :balance

      t.timestamps
    end

    add_reference :transactions, :account, foreign_key: true
  end
end
