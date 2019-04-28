class AddMoNumToProductionEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :production_events, :monum, :string
  end
end
