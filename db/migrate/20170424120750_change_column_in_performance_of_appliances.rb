class ChangeColumnInPerformanceOfAppliances < ActiveRecord::Migration[5.0]
  def change
  	change_column :performance_of_appliances, :performance_id, :integer
  end
end
