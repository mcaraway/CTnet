class CreateProductionLines < ActiveRecord::Migration[5.1]
  def change
    create_table :production_lines do |t|
      t.string :name

      t.timestamps
    end
  end
end
