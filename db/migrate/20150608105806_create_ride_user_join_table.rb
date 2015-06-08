class CreateRideUserJoinTable < ActiveRecord::Migration
  def change
    create_join_table :rides, :users do |t|
      # t.index [:ride_id, :user_id]
      # t.index [:user_id, :ride_id]
    end
  end
end
