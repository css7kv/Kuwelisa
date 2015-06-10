class CreateJoinTableLocationRide < ActiveRecord::Migration
  def change
    create_join_table :locations, :rides do |t|
      # t.index [:location_id, :ride_id]
      # t.index [:ride_id, :location_id]
    end
  end
end
