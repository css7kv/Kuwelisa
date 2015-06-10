class ChangePriceForRides < ActiveRecord::Migration
  def change
  	change_column :rides, :price, :integer
  end
end
