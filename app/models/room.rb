class Room < ApplicationRecord
	has_many :entry_rooms

	validates :name, presence: true
end
