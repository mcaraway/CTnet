class Shipment < ShipworksDbBase
  self.table_name = "Shipment"
  self.primary_key = "ShipmentID"
  
  class << self
    def count_by_range_sql(store_id, start_date, end_date, custom_sql)
      Shipment.find_by_sql([custom_sql, store_id, start_date, end_date]).count
    end
    
    def count_by_range(store_id, start_date, end_date)
      Shipment.joins("JOIN [Order] on [Order].OrderID = [Shipment].OrderID")
         .joins("JOIN [OrderItem] on [Order].OrderID = [OrderItem].OrderID")
          .where("StoreID=?", store_id)
          .where("ShipDate >= ? and ShipDate <= ? and [Order].LocalStatus='Shipped' and Shipment.Voided <> 1", start_date, end_date)
          .select("distinct [Order].OrderID").count
    end
 
    def usps_count_by_range_sql(store_id, start_date, end_date, custom_sql)
      Shipment.joins("JOIN [Order] on [Order].OrderID = [Shipment].OrderID")
         .joins("JOIN [OrderItem] on [Order].OrderID = [OrderItem].OrderID")
          .where("StoreID=?", store_id)
          .where("ShipDate >= ? and ShipDate <= ? and [Order].LocalStatus='Shipped' and Shipment.Voided <> 1", start_date, end_date)
          .where("ShipmentType = 15")
          .where(custom_sql)
          .select("distinct ShipmentID").count
    end
 
    def usps_count_by_range(store_id, start_date, end_date)
      Shipment.joins("JOIN [Order] on [Order].OrderID = [Shipment].OrderID")
         .joins("JOIN [OrderItem] on [Order].OrderID = [OrderItem].OrderID")
          .where("StoreID=?", store_id)
          .where("ShipDate >= ? and ShipDate <= ? and [Order].LocalStatus='Shipped' and Shipment.Voided <> 1", start_date, end_date)
          .where("ShipmentType = 15")
          .select("distinct ShipmentID").count
    end
    
    def usps_cost_by_range_sql(store_id, start_date, end_date, custom_sql)
      Shipment.joins("JOIN [Order] on [Order].OrderID = [Shipment].OrderID")
          .where("StoreID=?", store_id)
          .where("ShipDate >= ? and ShipDate <= ? and [Order].LocalStatus='Shipped' and Shipment.Voided <> 1", start_date, end_date)
          .where("ShipmentType = 15")
          .where(custom_sql)
          .sum("ShipmentCost")
    end
        
    def usps_cost_by_range(store_id, start_date, end_date)
      Shipment.joins("JOIN [Order] on [Order].OrderID = [Shipment].OrderID")
          .where("StoreID=?", store_id)
          .where("ShipDate >= ? and ShipDate <= ? and [Order].LocalStatus='Shipped' and Shipment.Voided <> 1", start_date, end_date)
          .where("ShipmentType = 15")
          .sum("ShipmentCost")
    end
  end
end
