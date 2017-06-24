class AddIndexesToVariousFields < ActiveRecord::Migration[5.0]
  def change
    add_index :entry_rooms, [:user_id, :room_id];
    add_index :rooms, :name;
  end
end
