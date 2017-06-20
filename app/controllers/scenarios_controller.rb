class ScenariosController < ApplicationController
    U = 230
    Phases_price = 6.99
    before_action :get_all_records, only: :new

  def index
    get_all_scenarios
    @array_of_ampers = [6, 10, 13, 16, 20, 25, 32, 40, 50, 63, 80]
    @amper_price_west = {}
    @amper_price_east = {}
    @array_of_ampers.each do |amper_value|
      @amper_price_west[amper_value] = amper_value * Phases_price
    end
    @amper_price_east[13] = 98.50
    @amper_price_east[16] = 121.00
    @amper_price_east[20] = 151.00
    @amper_price_east[25] = 189.00
    @amper_price_east[32] = 248.50
    @amper_price_east[40] = 310.50
    @amper_price_east[50] = 388.50
    @amper_price_east[63] = 489.00
    @amper_price_east[80] = 621.50
    @amper_price_east[100] = 981.00
    @amper_price_east[125] = 1635.00
    @amper_price_east[160] = 2093.00
    @amper_price_east[200] = 2616.50
    @amper_price_east[250] = 4089.00
    @amper_price_east[315] = 5152.00
    @amper_price_east[400] = 6542.50
  end

    def get_all_records
      @id = session[:user_id]
      @records = EntryRoom.where(user_id: @id)
      @hash_of_records = {}
      @records.each do |record|
        if @hash_of_records[record.room.name] == nil
          @hash_of_records[record.room.name] = {}
        end
        @hash_of_records[record.room.name][record.entry.performance_of_appliance.appliance.name] = {appliance_id: record.entry.performance_of_appliance.appliance.id, entry_id: record.entry.id, room_id: record.room.id, performance: record.entry.performance_of_appliance.performance, count: record.entry.count}
      end
    end

  def get_all_scenarios
    @scenarios = Scenario.where(user_id: current_user).order(power: :desc)
  end

  def destroy
    scenario = Scenario.find(params[:id])
    Scenario.transaction do
        scenario.scenario_of_appliances.delete_all
        scenario.destroy
    end
    get_all_scenarios
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
          flash.now[:success] = "Vytvorili ste si scenár používaných spotrebičov. Pre náhľad choďte na podstránku Dashboard."
        else
          flash.now[:danger] = "Nepodarilo sa vytvoriť scenár používaného spotrebiča."
        end
      end
    end
    redirect_to(new_user_scenario_path(current_user))
  end


end
