class AddGroupToProductionEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :production_events, :group, :string
  end
end
