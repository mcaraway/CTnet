class Shipment < ShipworksDbBase
  self.table_name = "Shipment"
  self.primary_key = "ShipmentID"
  
    class << self
 
    def count_by_range(store_id, start_date, end_date)
      Shipment.joins("JOIN [Order] on [Order].OrderID = [Shipment].OrderID")
         .joins("JOIN [OrderItem] on [Order].OrderID = [OrderItem].OrderID")
          .where("StoreID=?", store_id)
          .where("ShipDate >= ? and ShipDate < ? and [Order].LocalStatus='Shipped' and Shipment.Voided <> 1", start_date, end_date)
          .where("[OrderItem].sku in('FT002','FT004','FT005','FT005-A')")
          .where("[Order].ShipCountryCode not in ('CA','NG','GH','KE','ZA','IL','RU','RO','TZ','SC','SN','NA','BW','CD','CG','GA','CM','UG','ZW','AO','MU','SZ')")
          .select("ShipmentID").count
    end
 
    def usps_count_by_range(store_id, start_date, end_date)
      Shipment.joins("JOIN [Order] on [Order].OrderID = [Shipment].OrderID")
         .joins("JOIN [OrderItem] on [Order].OrderID = [OrderItem].OrderID")
          .where("StoreID=?", store_id)
          .where("ShipDate >= ? and ShipDate < ? and [Order].LocalStatus='Shipped' and Shipment.Voided <> 1", start_date, end_date)
          .where("[OrderItem].sku in('FT002','FT004','FT005','FT005-A')")
          .where("ShipmentType = 15")
          .select("ShipmentID").count
    end
    
    def usps_cost_by_range(store_id, start_date, end_date)
      Shipment.joins("JOIN [Order] on [Order].OrderID = [Shipment].OrderID")
          .where("StoreID=?", store_id)
          .where("ShipDate >= ? and ShipDate < ? and [Order].LocalStatus='Shipped' and Shipment.Voided <> 1", start_date-7, end_date-7)
          .where("ShipmentType = 15")
          .sum("ShipmentCost")
    end
  end
end
