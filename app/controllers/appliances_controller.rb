class AppliancesController < ApplicationController
	include AppliancesHelper

	before_action :index, only: :new
	before_action :get_my_rooms, only: :index

	def get_records_for(room_id)
		id = session[:user_id]
		records_for_specific_room = EntryRoom.where(user_id: id, room_id: room_id)
		@records = {}
		records_for_specific_room.each do |record|
			if @records[record.room.name] == nil
				@records[record.room.name] = {}
			end
			@records[record.room.name][record.entry.performance_of_appliance.appliance.name] = {appliance_id: record.entry.performance_of_appliance.appliance.id, entry_id: record.entry.id, room_id: record.room.id, performance: record.entry.performance_of_appliance.performance, count: record.entry.count}
		end
	end

	def create
		user = current_user
		Appliance.transaction do
			text = params[:room]
			text = text.strip
			params[:room] = text
			@appliance = Appliance.where(name: params[:appliance][:name].downcase!).first_or_create(appliance_params)
			@performance_of_appliance = @appliance.performance_of_appliances.where(performance_of_appliance_params).first_or_create(performance_of_appliance_params)
			@entry = @performance_of_appliance.entries.where(entry_params).first_or_create(entry_params)
			@room = Room.where(name: params[:room].downcase!).first_or_create(name: params[:room])
			user.entry_rooms.where(user_id: user.id, entry_id: @entry.id, room_id: @room.id).first_or_create(user_id: user.id, entry_id: @entry.id, room_id: @room.id)
		end
		get_my_rooms
		get_records_for(@room.id)
		respond_to do |format|
			format.js {render 'appliances/create'}
		end
	end

	def update_scenarios(entry_room, old_count, new_count, old_performance, new_performance)
		entry_room.scenario_of_appliances.each do |scenario_of_appliance|
			scenario_of_appliance.update_attributes(number_of_up: new_count)
			scenario = scenario_of_appliance.scenario
			power = scenario.power - ((old_performance/U)*old_count) + ((new_performance/U)*new_count)
			scenario.update_attributes(power: power)
		end
	end

	def update
		entry_room = EntryRoom.where(user_id: current_user.id, entry_id: params[:entry_id], room_id: params[:room_id]).first
		entry = entry_room.entry
		old_count = entry.count
		performance_of_appliance = entry.performance_of_appliance
		old_performance = performance_of_appliance.performance
		appliance = performance_of_appliance.appliance
		appliance_id = appliance.id
		performance_of_appliance_id = performance_of_appliance.id
		entry_id = entry.id
		appliance_can_delete = 0
		performance_can_delete = 0
		entry_can_delete = 0
		EntryRoom.transaction do
			if (appliance.name != params[:name].downcase!)
				if ((appliance_existing = Appliance.where(name: params[:name].downcase!)) && (appliance_existing.empty?))
					if(appliance.performance_of_appliances.length == 1)
						appliance.update_attributes(name: params[:name].downcase!)
						appliance_id = appliance.id
					else
						appliance_id = Appliance.create(name: params[:name]).id
					end
				else
					if(appliance.performance_of_appliances.length == 1 && appliance_existing[0].id != appliance_id)
						appliance_can_delete = 1
					end
					appliance_id = appliance_existing[0].id
				end
				if ((performance_of_appliance_existing = PerformanceOfAppliance.where(appliance_id: appliance_id, performance: performance_of_appliance.performance)) && (performance_of_appliance_existing.empty?))
					if (performance_of_appliance.entries.length == 1)
						performance_of_appliance.update_attributes(appliance_id: appliance_id)
						performance_of_appliance_id = performance_of_appliance.id
					else
						performance_of_appliance_id = PerformanceOfAppliance.create(appliance_id: appliance_id, performance: performance_of_appliance.performance).id
					end
				else
					if(performance_of_appliance.entries.length == 1 && performance_of_appliance_existing[0].id != performance_of_appliance_id)
						performance_can_delete = 1
					end
					performance_of_appliance_id = performance_of_appliance_existing[0].id
				end
				if ((entry_existing = Entry.where(performance_of_appliance_id: performance_of_appliance_id, count: entry.count)) && (entry_existing.empty?))
					if (entry.entry_rooms.length == 1)
						entry.update_attributes(performance_of_appliance_id: performance_of_appliance_id)
						entry_id = entry.id
					else
						entry_id = Entry.create(performance_of_appliance_id: performance_of_appliance_id, count: entry.count).id
					end
				else
					if(entry.entry_rooms.length == 1 && entry_existing[0].id != entry_id)
						entry_can_delete = 1
					end
					entry_id = entry_existing[0].id
				end
			end
			if (performance_of_appliance.performance != params[:performance].to_i)
				if ((performance_of_appliance_existing = PerformanceOfAppliance.where(appliance_id: appliance_id, performance: params[:performance].to_i)) && (performance_of_appliance_existing.empty?))
					if (performance_of_appliance.entries.length == 1)
						performance_of_appliance.update_attributes(performance: params[:performance].to_i)
						performance_of_appliance_id = performance_of_appliance.id
					else
						performance_of_appliance_id = PerformanceOfAppliance.create(appliance_id: appliance_id, performance: params[:performance].to_i).id
					end
				else
					if(performance_of_appliance.entries.length == 1 && performance_of_appliance_existing[0].id != performance_of_appliance_id)
						performance_can_delete = 1
					end
					performance_of_appliance_id = performance_of_appliance_existing[0].id
				end
				if ((entry_existing = Entry.where(performance_of_appliance_id: performance_of_appliance_id, count: entry.count)) && (entry_existing.empty?))
					if (entry.entry_rooms.length == 1)
						entry.update_attributes(performance_of_appliance_id: performance_of_appliance_id)
						entry_id = entry.id
					else
						entry_id = Entry.create(performance_of_appliance_id: performance_of_appliance_id, count: entry.count).id
					end
				else
					if(entry.entry_rooms.length == 1 && entry_existing[0].id != entry_id)
						entry_can_delete = 1
					end
					entry_id = entry_existing[0].id
				end
			end
			if (entry.count != params[:count].to_i)
				if ((entry_existing = Entry.where(performance_of_appliance_id: performance_of_appliance_id, count: params[:count].to_i)) && (entry_existing.empty?))
					if (entry.entry_rooms.length == 1)
						entry.update_attributes(count: params[:count].to_i)
						entry_id = entry.id
					else
						entry_id = Entry.create(performance_of_appliance_id: performance_of_appliance_id, count: params[:count].to_i).id
					end
				else
					if(entry.entry_rooms.length == 1 && entry_existing[0].id != entry_id)
						entry_can_delete = 1
					end
					entry_id = entry_existing[0].id
				end
			end
			entry_room.update_attributes(entry_id: entry_id)
			update_scenarios(entry_room, old_count, entry_room.entry.count, old_performance, entry_room.entry.performance_of_appliance.performance)
			if (appliance_can_delete == 1)
				Appliance.find(appliance.id).destroy
			end
			if (performance_can_delete == 1)
				PerformanceOfAppliance.find(performance_of_appliance.id).destroy
			end
			if (entry_can_delete == 1)
				Entry.find(entry.id).destroy
			end
		end
		get_records_for(params[:room_id])
		respond_to do |format|
			format.js {render 'appliances/update'}
		end
	end

	def destroy
		entry_room = EntryRoom.where(user_id: params[:user_id], entry_id: params[:entry_id], room_id: params[:room_id]).first
		entry = entry_room.entry
		room = entry_room.room
		performance = entry.performance_of_appliance
		appliance = performance.appliance
		EntryRoom.transaction do
			if entry_room.scenario_of_appliances.any?
				entry_room.scenario_of_appliances.each do |scenario_of_appliance|
					scenario = scenario_of_appliance.scenario
					scenario_of_appliance.destroy
					if scenario.scenario_of_appliances.empty?
						scenario.destroy
					end
				end
			end
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
		get_records_for(params[:room_id])
		respond_to do |format|
			format.js {render 'appliances/destroy'}
		end
	end

	def get_my_rooms
		id = session[:user_id]
		@rooms = EntryRoom.joins(:room).where("entry_rooms.user_id = ?", id).distinct("entry_rooms.room_id")
		@rooms = @rooms.map { |record|  record.room}
		@rooms.uniq!
	end

	def index
		respond_to do |format|
			if params[:room_id]
				get_records_for(params[:room_id])
				format.js{render 'appliances/showEntries'}
			else
				if @rooms.any?
					get_records_for(@rooms[0].id)
				end
				format.html{render 'index' }
			end
		end
	end


	private

	def appliance_params
		params.require(:appliance).permit(:name)
	end

	def performance_of_appliance_params
		params.permit(:performance, :appliance_id)
	end

	def entry_params
		params.permit(:count, :performance_of_appliance_id)
	end

	def room_params
		params.permit(:room)
	end

end
