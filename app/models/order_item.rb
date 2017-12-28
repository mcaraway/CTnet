class OrderItem < ShipworksDbBase
  self.table_name = "OrderItem"
  self.primary_key = "OrderItemID"
  belongs_to :order
  
  class << self
 
    def shipped_by_range_counts(store_id, start_date, end_date)
      rows = Rails.cache.fetch("order_item_counts") { 
         OrderItem.select("name, sku, sum(quantity) as quantity")
         .joins("JOIN [Order] on [Order].OrderID = [OrderItem].OrderID")
         .joins("JOIN Shipment on Shipment.OrderID = [Order].OrderID")
          .where("StoreID=?", store_id)
          .where("ShipDate >= ? and ShipDate < ? and [Order].LocalStatus='Shipped' and Shipment.Voided <> 1", start_date, end_date)
          .group("name,sku")
          .order("name,sku")
      }
    end
  end
end
