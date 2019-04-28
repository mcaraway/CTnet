class ChangeDateFormatInProductionEvent < ActiveRecord::Migration[5.1]
  def change
    change_column :production_events, :start, :datetime
    change_column :production_events, :end, :datetime
  end
end
