class AddStoreIdToFulfillmentBills < ActiveRecord::Migration[5.0]
  def change
    add_column :fulfillment_bills, :store_id, :integer
  end
end
