class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :appliances, :nazov, :name
  	rename_column :appliances, :cena, :cost
  	rename_column :entry_rooms, :zaznam_id, :entry_id
  	rename_column :entry_rooms, :miestnost_id, :room_id
  	rename_column :entrys, :vykon_spotrebica_id, :performance_of_appliance_id
  	rename_column :entrys, :pocet, :count
  	rename_column :performance_of_appliances, :vykon_id, :performance_id
  	rename_column :performance_of_appliances, :spotrebic_id, :appliance_id
  	rename_column :performances, :hodnota, :value
  	rename_column :registration_in_suppliers, :dodavatel_id, :supplier_id
  	rename_column :registration_in_suppliers, :od, :from
  	rename_column :registration_in_suppliers, :do, :to
  	rename_column :rooms, :druh, :name
  	rename_column :scenario_of_appliances, :pocet_zapnutych, :number_of_up
  	rename_column :scenario_of_appliances, :scenar_id, :scenario_id
  	rename_column :scenario_of_appliances, :spotrebic_id, :appliance_id
  	rename_column :scenarios, :zataz, :load
  	rename_column :suppliers, :meno, :name
  	rename_column :suppliers, :fixna_suma, :fix_sum
  	rename_column :users, :adresa, :address
  	rename_column :users, :heslo, :password
  end
end
