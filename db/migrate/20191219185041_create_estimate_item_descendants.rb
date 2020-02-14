class CreateEstimateItemDescendants < ActiveRecord::Migration[5.1]
  def change
    create_table :estimate_item_descendants do |t|
      t.integer :parent_id
      t.integer :child_id

      t.timestamps
    end
  end
end
