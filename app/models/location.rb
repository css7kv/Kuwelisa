class Location < ActiveRecord::Base
	has_and_belongs_to_many :rides
	geocoded_by :address
	after_validation :geocode 
end
