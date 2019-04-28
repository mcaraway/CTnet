class CreateProductionEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :production_events do |t|
      t.string :name
      t.date :start
      t.integer :duration

      t.timestamps
    end
  end
end
