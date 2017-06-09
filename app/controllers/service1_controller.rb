class Service1Controller < ApplicationController

	def create
		@appliance = createAppliance() 
		debugger
	end

end
