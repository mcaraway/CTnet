class AddContentToProductionEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :production_events, :content, :string
  end
end
