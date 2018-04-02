class Stateconst < FishbowlDbBase
  self.table_name = "stateconst"
  self.primary_key = "id"
  belongs_to :address, foreign_key: :stateId, primary_key: :id
end
