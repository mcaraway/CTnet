class Address < FishbowlDbBase
  self.table_name = "address"
  self.primary_key = "id"
  has_one :stateconst, foreign_key: :stateId, primary_key: :id
  has_one :countryconst, foreign_key: :countryId, primary_key: :id
  
  def to_string
    state = Stateconst.find_by(id: stateId)
    country = Countryconst.find_by(id: countryId)
    str = "\"#{name}\",\"#{address}\",\"#{city}\",\"#{state.name}\",\"#{zip}\",\"#{country.name}\""
  end
end
