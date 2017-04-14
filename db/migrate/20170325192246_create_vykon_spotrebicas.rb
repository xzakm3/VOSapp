class CreateVykonSpotrebicas < ActiveRecord::Migration[5.0]
  def change
    create_table :vykon_spotrebicas do |t|
      t.belongs_to :vykon, foreign_key: true
      t.belongs_to :spotrebic, foreign_key: true
    end
  end
end
