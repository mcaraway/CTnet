class BillItem
  attr_accessor :name, :description, :sku, :quantity, :price, :uom, :fishbowl_status
	def initialize(name, description, sku, quantity, price, uom = "ea", fishbowl_status = "")
	  @name = name
	  @description = description
	  @sku = sku
	  @quantity = quantity
	  @price = price
	  @uom = uom
	  @fishbowl_status = fishbowl_status
	end
	
  class << self	
  	def generate_array(order_item_counts)
  	  puts "Generating bill_items for #{order_item_counts.size}"
  	  bill_items = Array.new
  	  order_item_counts.each do |order_item| 
  	    product = Product.find_by sku: order_item.sku
  	    uom = product.nil? ? "" : (Uom.find_by id: product.uomId)
    	  bill_items << BillItem.new((product.nil? ? order_item.name : product.num), (product.nil? ? "error" : product.num), order_item.sku, 
    	   order_item.quantity, (product.nil? ? "error" : product.price), (product.nil? ? "error" : uom.code),(product.nil? ? "error" : "exists"))
  	  end
  	  bill_items
  	end
	end 
end