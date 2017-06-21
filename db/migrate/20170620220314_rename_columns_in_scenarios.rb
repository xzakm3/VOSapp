class RenameColumnsInScenarios < ActiveRecord::Migration[5.0]
  def change
    rename_column :scenarios, :number_of_up, :user_id
    rename_column :scenarios, :scenario_id, :power
    remove_column(:scenarios, :entry_room_id)
  end
end
