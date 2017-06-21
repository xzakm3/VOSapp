class AddForeignKeyToScenarioOfAppliances < ActiveRecord::Migration[5.0]
  def change
    remove_column(:scenario_of_appliances, :entry_room_id)
    add_reference :scenario_of_appliances, :entry_room, index: true
    add_foreign_key :scenario_of_appliances, :entry_rooms
    remove_column(:scenario_of_appliances, :scenario_id)
    add_reference :scenario_of_appliances, :scenario, index: true
    add_foreign_key :scenario_of_appliances, :scenarios
  end
end
