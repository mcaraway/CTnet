class Countryconst < FishbowlDbBase
  self.table_name = "countryconst"
  self.primary_key = "id"
  belongs_to :address
end
