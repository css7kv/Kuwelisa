class Ride < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_and_belongs_to_many :locations

	validates :startloc, :finishloc, :price, :datetime, :pcount, presence: true
	validates :price, :pcount, numericality: { only_integer: true }
	
end
