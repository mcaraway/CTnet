class Order < ShipworksDbBase
  self.table_name = "order"
  self.primary_key = "OrderID"
  belongs_to :store
  has_many :order_items
  has_many :shipments
  
  class << self
    def shipped_by_range(store_id, start_date, end_date, page = 1, per_page = 100)
      rows = Order.select("[order].OrderID, OrderNumber, OrderDate, [order].LocalStatus, Shipment.ShipmentCost, sku, Shipment.TrackingNumber")
         .joins("JOIN Shipment on Shipment.OrderID = [order].OrderID")
         .joins("JOIN [OrderItem] on [order].OrderID = [OrderItem].OrderID")
          .where("StoreID=?", store_id)
          .where("ShipDate >= ? and ShipDate < ? and [order].LocalStatus='Shipped' and Shipment.Voided <> 1", start_date, end_date)
          .paginate(:page => page, :per_page => per_page)
    end
    
    def shipped_by_range_sql(store_id, start_date, end_date, custom_sql, page = 1, per_page = 20)
      rows = Order.select("[order].OrderID, OrderNumber, OrderDate, [order].LocalStatus, Shipment.ShipmentCost, sku, Shipment.TrackingNumber")
         .joins("JOIN Shipment on Shipment.OrderID = [order].OrderID")
         .joins("JOIN [OrderItem] on [order].OrderID = [OrderItem].OrderID")
          .where("StoreID=?", store_id)
          .where("ShipDate >= ? and ShipDate < ? and [order].LocalStatus='Shipped' and Shipment.Voided <> 1", start_date, end_date)
          .where(custom_sql)
          .paginate(:page => page, :per_page => per_page)
    end
    
    def shipped_by_date(store_id, start_date, end_date)
      rows = Rails.cache.fetch("orders") { 
         Order.select("OrderDate, CASE [OrderItem].sku 
            WHEN 'FT002' THEN 'FT TWO (two week pack)'
            WHEN 'FT004' THEN 'FT FOUR (four week pack)'
            WHEN 'FT005' THEN 'FT NEXT'
            WHEN 'FT005-A' THEN 'FT FOUR (four week pack)'
            WHEN 'FT006M' THEN 'Shake It Baby Matcha 10ct'
            WHEN 'FT006V' THEN 'Shake It Baby Vanilla 10ct'
            WHEN 'FT007M' THEN 'Shake It Baby Matcha 20ct'
            WHEN 'FT007V' THEN 'Shake It Baby Vanilla 20ct'
          END as RollupItemName, sum([OrderItem].quantity) as quantity")
         .joins("JOIN Shipment on Shipment.OrderID = [order].OrderID")
         .joins("JOIN [OrderItem] on [order].OrderID = [OrderItem].OrderID")
          .where("StoreID=?", store_id)
          .where("ShipDate >= ? and ShipDate < ? and [order].LocalStatus='Shipped' and Shipment.Voided <> 1", start_date, end_date)
          .group("OrderDate, CASE [OrderItem].sku 
            WHEN 'FT002' THEN 'FT TWO (two week pack)'
            WHEN 'FT004' THEN 'FT FOUR (four week pack)'
            WHEN 'FT005' THEN 'FT NEXT'
            WHEN 'FT005-A' THEN 'FT FOUR (four week pack)'
            WHEN 'FT006M' THEN 'Shake It Baby Matcha 10ct'
            WHEN 'FT006V' THEN 'Shake It Baby Vanilla 10ct'
            WHEN 'FT007M' THEN 'Shake It Baby Matcha 20ct'
            WHEN 'FT007V' THEN 'Shake It Baby Vanilla 20ct'
          END")
      }
    end
    
    def items_shipped_by_date(start_date, end_date)
      rows = Rails.cache.fetch("items_shipped_by_date") { 
         Order.select("CONVERT(DATE,DATEADD(day, DATEDIFF(day, 0, OrderDate) /7*7, 0),101) as week, [OrderItem].sku, sum([OrderItem].quantity) as quantity")
         .joins("JOIN [OrderItem] on [order].OrderID = [OrderItem].OrderID")
         .joins("JOIN [Store] on [order].StoreID = [Store].StoreID")
          .where("[order].OrderDate >= ? and [order].OrderDate <= ?", start_date, end_date)
          .where("StoreName='Flat Tummy Tea'")
          .where("[OrderItem].sku in ('FT002','FT004','FT005','FT005-A','FT006V','FT006M','FT007V','FT007M')")
          .group("CONVERT(DATE,DATEADD(day, DATEDIFF(day, 0, OrderDate) /7*7, 0),101), [OrderItem].sku")
          .order("CONVERT(DATE,DATEADD(day, DATEDIFF(day, 0, OrderDate) /7*7, 0),101), [OrderItem].sku")
      }
    end
    
    def orders_by_week(start_date, end_date)
      rows = Rails.cache.fetch("orders_by_week") { 
         Order.select("CONVERT(DATE,DATEADD(day, DATEDIFF(day, 0, OrderDate) /7*7, 0),101) as week, sum([OrderItem].quantity) as quantity")
         .joins("JOIN [OrderItem] on [order].OrderID = [OrderItem].OrderID")
         .joins("JOIN [Store] on [order].StoreID = [Store].StoreID")
          .where("[order].OrderDate >= ? and [order].OrderDate <= ?", start_date, end_date)
          .where("StoreName='Flat Tummy Tea'")
          .group("CONVERT(DATE,DATEADD(day, DATEDIFF(day, 0, OrderDate) /7*7, 0),101)")
          .order("CONVERT(DATE,DATEADD(day, DATEDIFF(day, 0, OrderDate) /7*7, 0),101)")
      }
    end
    
    def shipped_by_range_count(store_id, start_date, end_date)
      rows = Order.select("count(*) as count")
         .joins("JOIN Shipment on Shipment.OrderID = [order].OrderID")
          .where("StoreID=?", store_id)
          .where("ShipDate >= ? and ShipDate < ? and LocalStatus='Shipped' and Shipment.Voided <> 1", start_date, end_date)
    end
  end
  
end
