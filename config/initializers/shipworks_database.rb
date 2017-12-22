# config/initializers/shipworks_database.rb

SHIPWORKS_DB = YAML.load_file(File.join(Rails.root, "config", "shipworks_database.yml"))[Rails.env.to_s]