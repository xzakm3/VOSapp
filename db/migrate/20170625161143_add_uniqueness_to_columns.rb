class AddUniquenessToColumns < ActiveRecord::Migration[5.0]
  def change
    remove_index :rooms, name: "index_rooms_on_name"
    add_index :rooms, :name, :unique => true
  end
end
