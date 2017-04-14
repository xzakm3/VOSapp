class Entry < ApplicationRecord
	has_one :performance_of_appliance
	has_many :entry_rooms
end
