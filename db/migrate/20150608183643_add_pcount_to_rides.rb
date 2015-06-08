class AddPcountToRides < ActiveRecord::Migration
  def change
    add_column :rides, :pcount, :integer
  end
end
