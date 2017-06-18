class RemoveForeignKeyFromScenarioAppliances2 < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :scenarios, column: :appliance_id
  end
end
