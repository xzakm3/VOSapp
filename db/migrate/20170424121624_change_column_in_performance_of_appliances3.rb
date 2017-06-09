class ChangeColumnInPerformanceOfAppliances3 < ActiveRecord::Migration[5.0]
  def change
  	remove_index :performance_of_appliances, name: "index_performance_of_appliances_on_performance_id"
  end
end
