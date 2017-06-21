class AddForeignKeyToPerformanceOfAppliance < ActiveRecord::Migration[5.0]
  def change
    remove_column(:performance_of_appliances, :appliance_id)
    add_reference :performance_of_appliances, :appliance, index: true
    add_foreign_key :performance_of_appliances, :appliances
  end
end
