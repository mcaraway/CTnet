json.extract! dbconnection, :id, :adapter, :mode, :host, :port, :username, :password, :database, :encoding, :created_at, :updated_at
json.url dbconnection_url(dbconnection, format: :json)
