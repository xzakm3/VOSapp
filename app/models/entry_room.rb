class EntryRoom < ApplicationRecord
	belongs_to :room
	belongs_to :entry
end
