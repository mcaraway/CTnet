class CreateEstimateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :estimate_items do |t|
      t.string :name
      t.integer :part_id
      t.float :amount
      t.integer :option_group_id

      t.timestamps
    end
  end
end
