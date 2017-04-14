class CreateZaznams < ActiveRecord::Migration[5.0]
  def change
    create_table :zaznams do |t|
      t.belongs_to :vykon_spotrebica, foreign_key: true
      t.integer :pocet
    end
  end
end
