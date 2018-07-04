class CreateEstimates < ActiveRecord::Migration[5.0]
  def change
    create_table :estimates do |t|
      t.string :name
      t.string :customer
      t.integer :customer_id
      t.string :notes
      t.integer :item_count
      t.integer :item_variations, default: 1
      t.boolean :include_case, default: true
      t.boolean :include_master_case, default: false
      t.float :unit_weight
      t.float :discount, default: 0.0

      t.timestamps
    end
  end
end
