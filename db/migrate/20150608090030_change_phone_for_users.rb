class ChangePhoneForUsers < ActiveRecord::Migration
  def change
  	change_column :users, :phone, :string, :null => false
  end
end
