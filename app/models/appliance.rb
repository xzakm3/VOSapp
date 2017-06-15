class Appliance < ApplicationRecord
	has_many :performance_of_appliances, :dependent => :destroy


	has_many :scenario_of_appliances

	validates :name, presence: true
				     
end
