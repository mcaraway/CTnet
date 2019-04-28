class RemoveDurationFromProductionEvent < ActiveRecord::Migration[5.1]
  def change
    remove_column :production_events, :duration, :integer
  end
end
