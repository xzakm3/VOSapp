class ChangeNumericTypeOfAttributeInScenarios < ActiveRecord::Migration[5.0]
  def change
    change_column :scenarios, :load, :decimal
  end
end
