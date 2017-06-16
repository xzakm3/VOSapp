class RemoveColumnFromAppliances < ActiveRecord::Migration[5.0]
  def change
    remove_column(:scenarios, :cost)
  end
end
