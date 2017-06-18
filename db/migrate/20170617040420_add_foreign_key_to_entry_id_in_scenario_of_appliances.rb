class AddForeignKeyToEntryIdInScenarioOfAppliances < ActiveRecord::Migration[5.0]
  def change
    remove_column(:scenarios, :entry_id)
    add_reference :scenarios, :entry, index: true
    add_foreign_key :scenarios, :entries
  end
end
