class AddCustomOrderSqlToFulfillmentBill < ActiveRecord::Migration[5.0]
  def change
    add_column :fulfillment_bills, :custom_order_list_sql, :string
  end
end
