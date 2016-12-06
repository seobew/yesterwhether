class CreatePastwheathers < ActiveRecord::Migration
  def change
    create_table :pastwheathers do |t|
      t.float  :temperature
      t.timestamps null: false
    end
  end
end
