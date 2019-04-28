class RemoveNameFromProductionEvent < ActiveRecord::Migration[5.1]
  def change
    remove_column :production_events, :name, :string
  end
end
