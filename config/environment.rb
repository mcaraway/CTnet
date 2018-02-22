# Load the Rails application.
require_relative 'application'

Encoding.default_external = Encoding::UTF_8

Encoding.default_internal = Encoding::UTF_8

Fishbowl.configure do |config|
  config.username = ENV["FISHBOWL_REST_USERNAME"]
  config.password = ENV["FISHBOWL_REST_PASSWORD"]
  config.host = ENV["FISHBOWL_REST_HOST"]
  config.app_id = ENV["FISHBOWL_REST_APP_ID"]
  config.app_name = ENV["FISHBOWL_REST_APP_NAME"]
  config.app_description = ENV["FISHBOWL_REST_APP_DESC"]
  config.debug = ENV["FISHBOWL_REST_DEBUG"]
end
# Initialize the Rails application.
Rails.application.initialize!
