class RenameOldTableToNewTable < ActiveRecord::Migration[5.0]
  def change
  	rename_table :dodavatels, :suppliers
  	rename_table :miestnosts, :rooms
  	rename_table :registracia_u_dodavatelas, :registration_in_suppliers
  	rename_table :scenar_spotrebicas, :scenario_of_appliances
  	rename_table :scenars, :scenarios
  	rename_table :spotrebics, :appliances
  	rename_table :vykon_spotrebicas, :performance_of_appliances
  	rename_table :vykons, :performances
  	rename_table :zaznam_miestnosts, :entry_rooms
  	rename_table :zaznams, :entrys
  end
end
