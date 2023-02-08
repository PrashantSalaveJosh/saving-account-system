class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :contact_no, :string
    add_column :users, :address, :string
    add_column :users, :dob, :date
    add_column :users, :gender, :string
    add_reference :users, :role, foreign_key: true
  end
end
