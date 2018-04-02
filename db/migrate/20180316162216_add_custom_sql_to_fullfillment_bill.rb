class AddCustomSqlToFullfillmentBill < ActiveRecord::Migration[5.0]
  def change
    add_column :fulfillment_bills, :custom_fulfillment_sql, :string
    add_column :fulfillment_bills, :custom_shipping_charge_sql, :string
  end
end
