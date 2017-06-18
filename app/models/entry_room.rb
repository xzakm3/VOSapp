class EntryRoom < ApplicationRecord
	belongs_to :room
	belongs_to :entry
	belongs_to :user
	has_many :scenario_of_appliances, :dependent => :destroy
end
