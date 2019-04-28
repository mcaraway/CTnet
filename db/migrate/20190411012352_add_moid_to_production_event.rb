class AddMoidToProductionEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :production_events, :moid, :integer
  end
end
