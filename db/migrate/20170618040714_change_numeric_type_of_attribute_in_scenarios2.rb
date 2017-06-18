class ChangeNumericTypeOfAttributeInScenarios2 < ActiveRecord::Migration[5.0]
  def change
    change_column :scenarios, :load, :numeric
  end
end
