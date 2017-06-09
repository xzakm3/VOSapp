class Appliance < ApplicationRecord
	has_many :performance_of_appliances, :dependent => :destroy


	has_many :scenario_of_appliances

	validates :name, presence: true

	validates :cost, presence: true,
				     numericality: { only_integer: true, greater_than: 0}
				     
end
