class ChangeColumnInPerformanceOfAppliances2 < ActiveRecord::Migration[5.0]
  def change
  	remove_foreign_key :performance_of_appliances, :performance_id if foreign_key_exists?(:performance_of_appliances, :performance_id)
  end
end
