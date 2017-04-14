class CreateDodavatels < ActiveRecord::Migration[5.0]
  def change
    create_table :dodavatels do |t|
      t.text :meno
      t.index :meno, unique: true
      t.integer :fixna_suma
      t.integer :vt
      t.integer :nt
    end
  end
end
