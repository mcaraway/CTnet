class BillItem
  attr_accessor :name, :description, :sku, :quantity, :price, :uom
	def initialize(name, description, sku, quantity, price, uom = "ea")
	  @name = name
	  @description = description
	  @sku = sku
	  @quantity = quantity
	  @price = price
	  @uom = uom
	end
	
  class << self	
  	def generate_array(order_item_counts)
  	  bill_items = Array.new
  	  order_item_counts.each do |order_item| 
  	    product = Product.find_by sku: order_item.sku
  	    if !product.nil? then
    	    uom = Uom.find_by id: product.uomId
    	    bill_items << BillItem.new(product.num, order_item.name, order_item.sku, order_item.quantity, product.price, uom.code)
  	    end
  	  end
  	  bill_items
  	end
	end 
end