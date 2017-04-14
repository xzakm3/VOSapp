class CreateZaznamMiestnosts < ActiveRecord::Migration[5.0]
  def change
    create_table :zaznam_miestnosts do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :zaznam, foreign_key: true
      t.belongs_to :miestnost, foreign_key: true
    end
  end
end
