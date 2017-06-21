class AddForeignKeyToEntries < ActiveRecord::Migration[5.0]
  def change
    remove_column(:entries, :performance_of_appliance_id)
    add_reference :entries, :performance_of_appliance, index: true
    add_foreign_key :entries, :performance_of_appliances
  end
end
