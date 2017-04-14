class CreateRegistraciaUDodavatelas < ActiveRecord::Migration[5.0]
  def change
    create_table :registracia_u_dodavatelas do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :dodavatel, foreign_key: true																			
      t.date :od
      t.date :do
    end
  end
end
