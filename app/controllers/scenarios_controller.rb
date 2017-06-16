class ScenariosController < ApplicationController

  before_action :index, only: :new

  def new
  end

  def create
  end

  def destroy
  end

  def index
    @id = session[:user_id]
    if params[:record] && params[:record][:room_id]
      @records = EntryRoom.joins(:room, :entry, "JOIN performance_of_appliances p ON performance_of_appliance_id = p.id", "JOIN appliances a ON appliance_id = a.id").where("entry_rooms.user_id = ? AND entry_rooms.room_id = ?", @id, params[:record][:room_id])
    else
      @records = EntryRoom.joins(:room, :entry, "JOIN performance_of_appliances p ON performance_of_appliance_id = p.id", "JOIN appliances a ON appliance_id = a.id").where("entry_rooms.user_id = ?", @id).merge(Room.order(name: :ASC))
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
end
