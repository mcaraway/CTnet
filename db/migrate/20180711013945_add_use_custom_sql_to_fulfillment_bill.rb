class AddUseCustomSqlToFulfillmentBill < ActiveRecord::Migration[5.1]
  def change
    add_column :fulfillment_bills, :use_custom_sql, :boolean, default: false
  end
end
