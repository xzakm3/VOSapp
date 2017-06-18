class ScenariosController < ApplicationController


  U = 230
  before_action :get_all_records, only: :new

  def index
    @hash_of_scenarios = {}

    @scenarios = Scenario.where(user_id: current_user)

    h = 3
  end

  def get_records_for(room_id)
    @id = session[:user_id]
    records_for_specific_room = EntryRoom.joins(:room, :entry, "JOIN performance_of_appliances p ON performance_of_appliance_id = p.id", "JOIN scenarios a ON appliance_id = a.id").where("entry_rooms.user_id = ? AND entry_rooms.room_id = ?", @id, room_id)
    @hash_for_specific_record = {}
    records_for_specific_room.each do |record|
      if @hash_for_specific_record[record.room.name] == nil
        @hash_for_specific_record[record.room.name] = {}
      end
      @hash_for_specific_record[record.room.name][record.entry.performance_of_appliance.appliance.name] = {appliance_id: record.entry.performance_of_appliance.appliance.id, entry_id: record.entry.id, room_id: record.room.id, performance: record.entry.performance_of_appliance.performance, count: record.entry.count}
    end
  end

  def get_all_records
    @id = session[:user_id]
    if params[:record] && params[:record][:room_id]
      @records = EntryRoom.joins(:room, :entry, "JOIN performance_of_appliances p ON performance_of_appliance_id = p.id", "JOIN scenarios a ON appliance_id = a.id").where("entry_rooms.user_id = ? AND entry_rooms.room_id = ?", @id, params[:record][:room_id])
    else
      @records = EntryRoom.joins(:room, :entry, "JOIN performance_of_appliances p ON performance_of_appliance_id = p.id", "JOIN scenarios a ON appliance_id = a.id").where("entry_rooms.user_id = ?", @id).merge(Room.order(name: :ASC))
    end
    @hash_of_records = {}
    @records.each do |record|
      if @hash_of_records[record.room.name] == nil
        @hash_of_records[record.room.name] = {}
      end
      @hash_of_records[record.room.name][record.entry.performance_of_appliance.appliance.name] = {appliance_id: record.entry.performance_of_appliance.appliance.id, entry_id: record.entry.id, room_id: record.room.id, performance: record.entry.performance_of_appliance.performance, count: record.entry.count}
    end
    @hash_of_records
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
    get_records_for(room[:id])
    respond_to do |format|
      format.js {render 'appliances/destroy'}
    end
  end

  def new
  end

  def create
    entry_room_ids = params[:entry_rooms]
    id = Scenario.last.id + 1
    i = 0

    Scenario.transaction do
      scenario = Scenario.new(id: id, user_id: current_user.id)
      entry_room_ids.each do |entry_room_id|
        entry_room = EntryRoom.where(id: entry_room_id)[0]
        performance = entry_room.entry.performance_of_appliance.performance
        i += (performance*1000)/U
      end
      scenario.power = i
      if scenario.save == false
        flash[:danger] = "Nepodarilo sa vytvoriť scenár používaných spotrebičov."
      end
      entry_room_ids.each do |entry_room_id|
        entry_room = EntryRoom.where(id: entry_room_id)[0]
        ups = entry_room.entry.count
        soa = ScenarioOfAppliance.new(number_of_up: ups, scenario_id: scenario.id, entry_room_id: entry_room_id)
        if soa.save
          flash[:success] = "Vytvorili ste si scenár používaných spotrebičov. Pre náhľad choďte na podstránku Dashboard."
        else
          flash[:danger] = "Nepodarilo sa vytvoriť scenár používaného spotrebiča."
        end
        h = 13
      end
    end
    redirect_to(new_user_scenario_path(current_user))
  end




end
