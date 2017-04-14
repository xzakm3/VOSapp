class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.column(:heslo, 'char(40)')
      t.text :email
      t.index :email, unique: true
      t.text :adresa
      t.index :adresa, unique: true
      t.timestamps
    end
  end
end
