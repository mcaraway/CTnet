class ShipworksDbBase < ActiveRecord::Base  
  self.abstract_class = true
  establish_connection(
  :adapter => "sqlserver",
  :mode => "dblib",
  :pool => 5,
  :database => ENV["SHIPWORKS_DB"],
  :username => ENV["SHIPWORKS_USERNAME"],
  :password=> ENV["SHIPWORKS_PASSWORD"],
  :host => ENV["SHIPWORKS_HOST"],
  :port => ENV["SHIPWORKS_PORT"]
  )
end