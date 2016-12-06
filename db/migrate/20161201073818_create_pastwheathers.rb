class CreatePastwheathers < ActiveRecord::Migration
  def change
    create_table :pastwheathers do |t|
      t.float  :temperature
      t.int :x_point
      t.int :y_point
      
      t.timestamps null: false
    end
  end
end
