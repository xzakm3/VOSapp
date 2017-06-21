class Appliance < ApplicationRecord
	has_many :performance_of_appliances, :dependent => :destroy
	validates :name, presence: true

end
