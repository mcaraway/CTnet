class AddIncludeUspsCharge < ActiveRecord::Migration[5.0]
  def change
    add_column :fulfillment_bills, :include_usps_charge, :boolean, default: true
  end
end
