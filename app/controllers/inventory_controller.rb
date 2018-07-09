class InventoryController < ApplicationController

  # GET /inventory
  # GET /inventory.json
  def index
    @inventory_items = InventoryItem.load_inventory(current_user.product_tree_id)
  end
  
end
