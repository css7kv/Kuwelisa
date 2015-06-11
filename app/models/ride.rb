class Ride < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_and_belongs_to_many :locations

	validates :startloc, :finishloc, :price, :datetime, :pcount, presence: true
	validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	validates :pcount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
