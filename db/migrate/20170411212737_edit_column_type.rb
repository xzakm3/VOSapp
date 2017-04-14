class EditColumnType < ActiveRecord::Migration[5.0]
  def change
  		change_column :users, :password_digest, :string, :limit => 60
  end
end
