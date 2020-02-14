class Part < FishbowlDbBase
  self.table_name = "part"
  self.primary_key = "id"
  
  def self.search(term)
    order(:num).where("num like ?", "%#{term}%")
  end
end
