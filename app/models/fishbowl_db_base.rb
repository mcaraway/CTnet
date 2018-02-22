class FishbowlDbBase < ActiveRecord::Base  
  self.abstract_class = true
  establish_connection(
  :adapter => "mysql2",
  :encoding => "utf8",
  :database => ENV["FISHBOWL_DB"],
  :username => ENV["FISHBOWL_USERNAME"],
  :password=> ENV["FISHBOWL_PASSWORD"],
  :host => ENV["FISHBOWL_HOST"],
  :port => ENV["FISHBOWL_PORT"]
  )
end