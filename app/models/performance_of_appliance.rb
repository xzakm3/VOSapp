class PerformanceOfAppliance < ApplicationRecord
	has_many :entries
	belongs_to :appliance

	validates :performance, presence: true,
						numericality: { only_integer: true, greater_than: 0 }
end
