class AddForeignKeyToEntryIdInScenarioOfAppliances2 < ActiveRecord::Migration[5.0]
  def change
    remove_index :scenarios, name: "index_scenario_of_appliances_on_entry_id"
    remove_foreign_key :scenarios, column: :entry_id
    remove_column(:scenarios, :entry_id)
    add_reference :scenarios, :entry_room, index: true
    add_foreign_key :scenarios, :entry_rooms
  end
end
