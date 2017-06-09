class ChangeColumnInPerformanceOfAppliances5 < ActiveRecord::Migration[5.0]
  def change
  	remove_foreign_key :performance_of_appliances, :performances
  end
end
