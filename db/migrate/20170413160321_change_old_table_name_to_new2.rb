class ChangeOldTableNameToNew2 < ActiveRecord::Migration[5.0]
  def change
  	rename_table :entrys, :entries
  end
end
