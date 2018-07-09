class ProductTree < FishbowlDbBase
  self.table_name = "producttree"
  self.primary_key = "id"
  
  class << self  
    def all_cached
      Rails.cache.fetch("producttree") { ProductTree.all }
    end
    def inventory(product_tree_id)
      Shipment.find_by_sql([custom_sql, store_id, start_date, end_date]).count
    end
  end
  
private

  def flush_cache
    Rails.cache.delete('producttree')
  end  
end
