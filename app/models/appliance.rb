class Appliance < ApplicationRecord
	has_many :performance_of_appliances, :dependent => :destroy
	validates :name, presence: true
	before_save :downcase_fields

	def downcase_fields
		self.name.downcase!
	end

end
