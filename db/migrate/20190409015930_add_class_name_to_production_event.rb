class AddClassNameToProductionEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :production_events, :className, :string
  end
end
