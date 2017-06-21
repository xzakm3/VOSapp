class AddForeignKeyToScenarios < ActiveRecord::Migration[5.0]
  def change
    remove_column(:scenarios, :user_id)
    add_reference :scenarios, :user, index: true
    add_foreign_key :scenarios, :users
  end
end
