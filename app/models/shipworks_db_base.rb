class ShipworksDbBase < ActiveRecord::Base  
  self.abstract_class = true
  establish_connection SHIPWORKS_DB
end