class CreateScenars < ActiveRecord::Migration[5.0]
  def change
    create_table :scenars do |t|
      t.integer :zataz
      t.belongs_to :user, foreign_key: true
    end
  end
end
