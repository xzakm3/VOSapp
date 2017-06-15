class RemoveColumnFromAppliances < ActiveRecord::Migration[5.0]
  def change
    remove_column(:appliances, :cost)
  end
end
