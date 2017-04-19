class ChangeColumnName3 < ActiveRecord::Migration[5.0]
  def change
  	rename_column :users, :activated_digest, :activation_digest
  end
end
