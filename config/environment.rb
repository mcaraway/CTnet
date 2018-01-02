# Load the Rails application.
require_relative 'application'

Encoding.default_external = Encoding::UTF_8

Encoding.default_internal = Encoding::UTF_8

Fishbowl.configure do |config|
  config.username = "admin"
  config.password = "admintea"
  # config.host = "carawaytea.dnsalias.com:28192"
  config.host = "24.186.72.206"
  config.app_id = "5150"
  config.app_name = "CTnet"
  config.app_description = "Caraway Tea Network App"
  config.debug = true
end

# Initialize the Rails application.
Rails.application.initialize!
