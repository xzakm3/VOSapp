class AppliancesController < ApplicationController
	def index
		@id = session[:user_id]
		if  params[:act] == "group"
			@groups = EntryRoom.joins(:room, :entry).where("entry_rooms.user_id = ?", @id).group('name').sum('count')
		else
			@rooms = EntryRoom.joins(:room).where("entry_rooms.user_id = ?", @id).distinct("entry_rooms.room_id")
			@rooms = @rooms.map { |record|  record.room}
			@rooms.uniq!
			if params[:record] && params[:record][:room_id]
				@records = EntryRoom.joins(:room, :entry, "JOIN performance_of_appliances p ON performance_of_appliance_id = p.id", "JOIN appliances a ON appliance_id = a.id").where("entry_rooms.user_id = ? AND entry_rooms.room_id = ?", @id, params[:record][:room_id]).merge(Room.order(name: :ASC))
			else
				@records = EntryRoom.joins(:room, :entry, "JOIN performance_of_appliances p ON performance_of_appliance_id = p.id", "JOIN appliances a ON appliance_id = a.id").where("entry_rooms.user_id = ?", @id).merge(Room.order(name: :ASC))
				@hash_of_records = {}
				@records.each do |record|
					if @hash_of_records[record.room.name] == nil
						@hash_of_records[record.room.name] = {}
					end
					@hash_of_records[record.room.name][record.entry.performance_of_appliance.appliance.name] = {performance: record.entry.performance_of_appliance.performance, count: record.entry.count}
				end
			end
			@records = @records.paginate(page: params[:page], per_page: 10)
			return @records, @hash_of_records
		end
	end

	def destroy
		entry_room = EntryRoom.where(user_id: params[:user_id], entry_id: params[:entry_id], room_id: params[:room_id]).first
		entry = entry_room.entry
		room = entry_room.room
		performance = entry.performance_of_appliance
		appliance = performance.appliance
		EntryRoom.transaction do
			entry_room.destroy
			if room.entry_rooms.empty?
				room.destroy
			end
			if entry.entry_rooms.empty?
				entry.destroy
			end
			if performance.entries.empty?
				performance.destroy
			end
			if appliance.performance_of_appliances.empty?
				appliance.destroy
			end
		end
		redirect_to user_appliances_path(current_user)
	end

	def new
	end

	def create
		user = current_user
		Appliance.transaction do
			appliance = Appliance.where(name: params[:appliance][:name]).first_or_create(appliance_params)
        	performance_of_appliance = appliance.performance_of_appliances.where(performance_of_appliance_params).first_or_create(performance_of_appliance_params)
        	entry = performance_of_appliance.entries.where(entry_params).first_or_create(entry_params)
        	room = Room.where(name: params[:room][:name]).first_or_create(room_params)
        	user.entry_rooms.where(user_id: user.id, entry_id: entry.id, room_id: room.id).first_or_create(user_id: user.id, entry_id: entry.id, room_id: room.id)
        	
        	flash.now[:success] = "Successfull adition of new appliance"
			render 'new'
		end

	end 

	private

  		def appliance_params
    		params.require(:appliance).permit(:name, :cost)
  		end

  		def performance_of_appliance_params
  			params.permit(:performance, :appliance_id) 
  		end

  		def entry_params
  			params.permit(:count, :performance_of_appliance_id)
  		end

  		def room_params
  			params.require(:room).permit(:name)
  		end

end
