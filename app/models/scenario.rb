class Scenario < ApplicationRecord
	has_many :scenario_of_appliances, :dependent => :destroy
	belongs_to :user
end
