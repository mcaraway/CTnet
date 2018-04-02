class BillOrderInfo
  attr_accessor :order_number, :order_date, :status, :shipment_cost, :name, :sku, :tracking
	def initialize(order_number, order_date, status, shipment_cost, name, sku, tracking)
	  @order_number = order_number
	  @order_date = order_date
	  @status = status
	  @shipment_cost = shipment_cost
	  @name = name
	  @sku = sku
	  @tracking = tracking
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
        if !product.nil? then
    	    bill_order_infos << BillOrderInfo.new(order.OrderNumber, order.OrderDate, order.LocalStatus, order.ShipmentCost, 
    	     product.num, product.sku, order.TrackingNumber)
    	  end
  	  end
  	  bill_order_infos
  	end
	end 
end