class Order < ShipworksDbBase
  self.table_name = "order"
  self.primary_key = "OrderID"
  belongs_to :store
  has_many :order_items
  has_many :shipments
  
  class << self
    def shipped_by_range(store_id, start_date, end_date)
      rows = Rails.cache.fetch("orders") { 
         Order.select("[order].OrderID, OrderNumber, OrderDate, LocalStatus")
         .joins("JOIN Shipment on Shipment.OrderID = [order].OrderID")
          .where("StoreID=?", store_id)
          .where("ShipDate >= ? and ShipDate < ? and LocalStatus='Shipped'", start_date, end_date)
      }
    end
    
    def shipped_by_range_counts(store_id, start_date, end_date)
      rows = Rails.cache.fetch("orders") { 
         Order.select("[order].OrderID, OrderNumber, OrderDate, LocalStatus")
         .joins("JOIN Shipment on Shipment.OrderID = [order].OrderID")
          .where("StoreID=?", store_id)
          .where("ShipDate >= ? and ShipDate < ? and LocalStatus='Shipped'", start_date, end_date)
      }
    end
  end
  
end
