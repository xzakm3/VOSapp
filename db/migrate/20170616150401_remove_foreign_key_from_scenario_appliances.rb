class RemoveForeignKeyFromScenarioAppliances < ActiveRecord::Migration[5.0]
  def change
    remove_index :scenarios, name: "index_scenario_of_appliances_on_appliance_id"
  end
end
