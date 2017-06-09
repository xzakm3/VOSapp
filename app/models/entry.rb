class Entry < ApplicationRecord
	belongs_to :performance_of_appliance
	has_many :entry_rooms

	validates :count, presence: true,
				     numericality: { only_integer: true, greater_than: 0}
end
