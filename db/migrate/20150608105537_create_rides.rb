class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.datetime :datetime
      t.time :duration
      t.string :startloc
      t.string :finishloc
      t.float :price
      t.integer :driverid

      t.timestamps null: false
    end
  end
end
