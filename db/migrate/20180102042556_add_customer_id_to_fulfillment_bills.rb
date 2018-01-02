class AddCustomerIdToFulfillmentBills < ActiveRecord::Migration[5.0]
  def change
    add_column :fulfillment_bills, :customer_id, :integer
  end
end
