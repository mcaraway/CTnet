class AddCustomSqlToFulfillmentBill < ActiveRecord::Migration[5.0]
  def change
    add_column :fulfillment_bills, :custom_sql, :string
  end
end
