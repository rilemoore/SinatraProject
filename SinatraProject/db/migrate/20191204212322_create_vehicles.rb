class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :make
      t.string :model
      t.decimal :money_invested
      t.integer :user_id
    end
  end
end
