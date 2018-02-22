json.extract! restconnection, :id, :host, :appname, :appid, :description, :debug, :username, :password, :created_at, :updated_at
json.url restconnection_url(restconnection, format: :json)
