class CreateBranches < ActiveRecord::Migration[7.0]
  def change
    create_table :branches do |t|
      t.string :name
      t.string :contact_no
      t.string :address
      t.string :ifsc

      t.timestamps
    end
  end
end
