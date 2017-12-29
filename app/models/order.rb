class Order < ShipworksDbBase
  self.table_name = "order"
  self.primary_key = "OrderID"
  belongs_to :store
  has_many :order_items
  has_many :shipments
  
  class << self
    def shipped_by_range(store_id, start_date, end_date)
      rows = Rails.cache.fetch("orders") { 
         Order.select("[order].OrderID, OrderNumber, OrderDate, [order].LocalStatus, Shipment.ShipmentCost as RollupItemQuantity, CASE [OrderItem].sku 
            WHEN 'FT002' THEN 'FT TWO (two week pack)'
            WHEN 'FT004' THEN 'FT FOUR (four week pack)'
            WHEN 'FT005' THEN 'FT NEXT'
            WHEN 'FT005-A' THEN 'FT FOUR (four week pack)'
            WHEN 'FT006M' THEN 'Shake It Baby Matcha 10ct'
            WHEN 'FT006V' THEN 'Shake It Baby Vanilla 10ct'
            WHEN 'FT007M' THEN 'Shake It Baby Matcha 20ct'
            WHEN 'FT007V' THEN 'Shake It Baby Vanilla 20ct'
          END as RollupItemName")
         .joins("JOIN Shipment on Shipment.OrderID = [order].OrderID")
         .joins("JOIN [OrderItem] on [order].OrderID = [OrderItem].OrderID")
          .where("StoreID=?", store_id)
          .where("ShipDate >= ? and ShipDate < ? and [order].LocalStatus='Shipped' and Shipment.Voided <> 1", start_date, end_date)
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
