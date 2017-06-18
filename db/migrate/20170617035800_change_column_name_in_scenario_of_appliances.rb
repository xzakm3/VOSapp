class ChangeColumnNameInScenarioOfAppliances < ActiveRecord::Migration[5.0]
  def change
    rename_column :scenarios, :appliance_id, :entry_id
  end
end
