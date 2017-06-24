class Room < ApplicationRecord
	has_many :entry_rooms
	validates :name, presence: true
	before_save :downcase_fields

	def downcase_fields
		self.name.downcase!
	end
end
