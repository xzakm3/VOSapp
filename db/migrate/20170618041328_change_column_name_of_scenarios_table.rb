class ChangeColumnNameOfScenariosTable < ActiveRecord::Migration[5.0]
  def change
    rename_column :scenarios, :load, :power
  end
end
