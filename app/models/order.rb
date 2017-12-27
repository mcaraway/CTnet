class Order < ShipworksDbBase
  self.table_name = "order"
  self.primary_key = "OrderID"
  belongs_to :store
  has_many :order_items
  
end
