class Store < ShipworksDbBase
  self.table_name = "store"
  self.primary_key = "StoreID"
  after_commit :flush_cache  
  has_many :orders
  
  class << self  
    def all_cached
      Rails.cache.fetch("stores") { Store.where(Enabled: true) }
    end
  end
  
private

  def flush_cache
    Rails.cache.delete('stores')
  end  
end
