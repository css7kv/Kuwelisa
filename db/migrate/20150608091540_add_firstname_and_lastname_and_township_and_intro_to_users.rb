class AddFirstnameAndLastnameAndTownshipAndIntroToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :township, :string
    add_column :users, :intro, :text
  end
end
