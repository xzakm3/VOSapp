class Performance < ApplicationRecord
	has_many :performance_of_appliances

	validates :performance, presence: true
end
