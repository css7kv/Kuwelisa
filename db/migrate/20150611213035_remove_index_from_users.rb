class RemoveIndexFromUsers < ActiveRecord::Migration
  # # Uncomment when pushing to heroku
  def up
     sql = 'DROP INDEX index_users_on_email'
     ActiveRecord::Base.connection.execute(sql)
   end
end
