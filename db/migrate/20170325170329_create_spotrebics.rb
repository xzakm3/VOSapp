class CreateSpotrebics < ActiveRecord::Migration[5.0]
  def change
    create_table :spotrebics do |t|
    	t.text :nazov
        t.integer :cena
    	t.index :nazov, unique: true
    end
  end
end
