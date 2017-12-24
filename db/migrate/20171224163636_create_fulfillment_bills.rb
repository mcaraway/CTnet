class CreateFulfillmentBills < ActiveRecord::Migration[5.0]
  def change
    create_table :fulfillment_bills do |t|
      t.string :store_name
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
