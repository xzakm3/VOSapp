class Entry < ApplicationRecord
	belongs_to :performance_of_appliance
	has_many :entry_rooms

	validates :count, presence: true
end
