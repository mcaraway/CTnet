class InventoryItem
  attr_accessor  :product_number, :product_description, :quantity, :uom, :lot
  def initialize(product_number, product_description, quantity, uom = "ea",lot)
    @product_number = product_number
    @product_description = product_description
    @quantity = quantity
    @uom = uom
    @lot = lot
  end
  
  class << self 
    def load_inventory(product_tree_id)
      items = Array.new
      inventory_items = Product.inventory_by_product_tree(product_tree_id)
      inventory_items.each do |item| 
        trackingValue = item.trackValue.nil? ? "" : item.trackValue.gsub!('~','')
        items << InventoryItem.new(item.num, item.description, item.Quantity, item.code, trackingValue)
      end
      items
    end
  end 
end