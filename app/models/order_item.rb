class OrderItem < ShipworksDbBase
  self.table_name = "OrderItem"
  self.primary_key = "OrderItemID"
  belongs_to :order
  
  class << self
 
    def shipped_by_range_counts_with_sql(store_id, start_date, end_date, custom_sql)
      rows = OrderItem.find_by_sql([custom_sql, store_id, start_date, end_date])
    end
    
    def shipped_by_range_counts(store_id, start_date, end_date)
      rows = OrderItem.select("sku, name, sum(quantity) as quantity")
         .joins("JOIN [Order] on [Order].OrderID = [OrderItem].OrderID")
         .joins("JOIN Shipment on Shipment.OrderID = [Order].OrderID")
          .where("StoreID=?", store_id)
          .where("ShipDate >= ? and ShipDate < ? and [Order].LocalStatus='Shipped' and Shipment.Voided <> 1", start_date, end_date)
          .group("sku")
          .order("name")
      # rows = OrderItem.select("CASE sku 
            # WHEN 'FT002' THEN 'FTT 2W Complete'
            # WHEN 'FT004' THEN 'FTT 4W Complete'
            # WHEN 'FT005' THEN 'FTT FT Next Complete'
            # WHEN 'FT005-A' THEN 'FTT 4W Complete'
            # WHEN 'FT006M' THEN 'Shake It Baby 2 Week - Matcha'
            # WHEN 'FT006V' THEN 'Shake It Baby 2 Week - Vanilla'
            # WHEN 'FT007M' THEN 'Shake It Baby 4 Week - Matcha'
            # WHEN 'FT007V' THEN 'Shake It Baby 4 Week - Vanilla'
          # END as name, sum(quantity) as quantity")
         # .joins("JOIN [Order] on [Order].OrderID = [OrderItem].OrderID")
         # .joins("JOIN Shipment on Shipment.OrderID = [Order].OrderID")
          # .where("StoreID=?", store_id)
          # .where("ShipDate >= ? and ShipDate < ? and [Order].LocalStatus='Shipped' and Shipment.Voided <> 1", start_date, end_date)
          # .where("[OrderItem].sku in ('FT002','FT004','FT005','FT005-A','FT007V','FT007M','FT006V','FT006M')")
          # .where("[Order].ShipCountryCode not in ('CA','NG','GH','KE','ZA','IL','RU','RO','TZ','SC','SN','NA','BW','CD','CG','GA','CM','UG','ZW','AO','MU','SZ')")
          # .group("CASE sku 
            # WHEN 'FT002' THEN 'FTT 2W Complete'
            # WHEN 'FT004' THEN 'FTT 4W Complete'
            # WHEN 'FT005' THEN 'FTT FT Next Complete'
            # WHEN 'FT005-A' THEN 'FTT 4W Complete'
            # WHEN 'FT006M' THEN 'Shake It Baby 2 Week - Matcha'
            # WHEN 'FT006V' THEN 'Shake It Baby 2 Week - Vanilla'
            # WHEN 'FT007M' THEN 'Shake It Baby 4 Week - Matcha'
            # WHEN 'FT007V' THEN 'Shake It Baby 4 Week - Vanilla'
          # END")
          # .order("name")
    end
  end
end
