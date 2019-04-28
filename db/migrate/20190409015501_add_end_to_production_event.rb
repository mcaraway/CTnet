class AddEndToProductionEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :production_events, :end, :date
  end
end
