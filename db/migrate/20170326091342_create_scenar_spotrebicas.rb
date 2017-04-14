class CreateScenarSpotrebicas < ActiveRecord::Migration[5.0]
  def change
    create_table :scenar_spotrebicas do |t|
      t.integer :pocet_zapnutych
      t.belongs_to :scenar, foreign_key: true
      t.belongs_to :spotrebic, foreign_key: true
    end
  end
end
