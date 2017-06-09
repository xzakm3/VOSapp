class PerformanceOfAppliance < ApplicationRecord
	has_many :entries
	
	belongs_to :appliance
end
