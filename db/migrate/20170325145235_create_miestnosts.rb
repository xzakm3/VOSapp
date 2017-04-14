class CreateMiestnosts < ActiveRecord::Migration[5.0]
  def change
    create_table :miestnosts do |t|
    	t.text :druh
    end
  end
end
