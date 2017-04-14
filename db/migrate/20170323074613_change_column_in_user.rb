class ChangeColumnInUser < ActiveRecord::Migration[5.0]
  def change
  	change_column_null :users, :adresa, false
  end
end
