class ScenariosController < ApplicationController
    include ScenariosHelper
    U = 230
    before_action :get_my_records, only: :new

  def index
  end

  def destroy
    scenario = Scenario.find(params[:id])
    Scenario.transaction do
        scenario.scenario_of_appliances.delete_all
        scenario.destroy
    end
    get_my_scenarios
    respond_to do |format|
      format.js{render 'scenarios/destroy'}
    end
  end

  def new
  end

  def create
    entry_room_ids = params[:entry_rooms]
    if(Scenario.count == 0)
      id = 0
    else
      id = Scenario.last.id + 1
    end

    i = 0

    Scenario.transaction do
      scenario = Scenario.new(id: id, user_id: current_user.id)
      entry_room_ids.each do |entry_room_id|
        entry_room = EntryRoom.where(id: entry_room_id)[0]
        performance = entry_room.entry.performance_of_appliance.performance
        i += ((performance/U)*entry_room.entry.count)
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
      end
    end
    redirect_to(new_user_scenario_path(current_user))
  end

  private

  def get_my_records
    @id = session[:user_id]
    @my_records = EntryRoom.where(user_id: @id)
    @records = {}
    @my_records.each do |record|
      if @records[record.room.name] == nil
        @records[record.room.name] = {}
      end
      @records[record.room.name][record.entry.performance_of_appliance.appliance.name] = {appliance_id: record.entry.performance_of_appliance.appliance.id, entry_id: record.entry.id, room_id: record.room.id, performance: record.entry.performance_of_appliance.performance, count: record.entry.count}
    end
  end

end
