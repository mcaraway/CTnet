class AddProductTreeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :product_tree_id, :integer
  end
end
