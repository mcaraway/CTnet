class BillOrderInfo
  attr_accessor :order_number, :order_date, :status, :shipment_cost, :name, :sku, :tracking, :fishbowl_status
	def initialize(order_number, order_date, status, shipment_cost, name, sku, tracking, fishbowl_status)
	  @order_number = order_number
	  @order_date = order_date
	  @status = status
	  @shipment_cost = shipment_cost
	  @name = name
	  @sku = sku
	  @tracking = tracking
	  @fishbowl_status = fishbowl_status
	end
	
  class << self	
  	def generate_array(orders)
  	  unique_orders_by_sku = orders.uniq{|x| x.sku}
  	  skus = Array.new
  	  unique_orders_by_sku.each do |order|
  	    skus << order.sku
  	  end
  	  puts "test #{skus}"
  	  products = Product.where('sku in (?)', skus)
  	  
  	  bill_order_infos = Array.new
  	  orders.each do |order| 
  	    product = products.detect{|x| x.sku == order.sku}
        bill_order_infos << BillOrderInfo.new(order.OrderNumber, order.OrderDate, order.LocalStatus, order.ShipmentCost, 
    	     (product.nil? ? 'error' : product.num), (product.nil? ? order.sku : product.sku), order.TrackingNumber, (product.nil? ? 'error' : 'exists'))
  	  end
  	  bill_order_infos
  	end
	end 
end