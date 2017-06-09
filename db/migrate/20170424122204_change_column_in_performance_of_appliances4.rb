class ChangeColumnInPerformanceOfAppliances4 < ActiveRecord::Migration[5.0]
  def change
  	add_index :performance_of_appliances, :performance_id
  end
end
