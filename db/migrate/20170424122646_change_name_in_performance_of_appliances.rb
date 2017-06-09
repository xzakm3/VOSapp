class ChangeNameInPerformanceOfAppliances < ActiveRecord::Migration[5.0]
  def change
  	rename_column :performance_of_appliances, :performance_id, :performance
  end
end
