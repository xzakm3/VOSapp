class CreateVykons < ActiveRecord::Migration[5.0]
  def change
    create_table :vykons do |t|
    	t.integer :hodnota
    end
  end
end
