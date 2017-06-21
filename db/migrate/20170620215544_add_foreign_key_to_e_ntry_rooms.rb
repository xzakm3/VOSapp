class AddForeignKeyToENtryRooms < ActiveRecord::Migration[5.0]
  def change
    remove_column(:entry_rooms, :entry_id)
    remove_column(:entry_rooms, :room_id)
    remove_column(:entry_rooms, :user_id)
    add_reference :entry_rooms, :entry, index: true
    add_reference :entry_rooms, :room, index: true
    add_reference :entry_rooms, :user, index: true
    add_foreign_key :entry_rooms, :rooms
    add_foreign_key :entry_rooms, :entries
    add_foreign_key :entry_rooms, :users
  end
end
