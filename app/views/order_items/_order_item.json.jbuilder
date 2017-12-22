json.extract! order_item, :id, :RowVersion, :OrderID, :Name, :Code, :SKU, :ISBN, :UPC, :Description, :Location, :Image, :Thumbnail, :UnitPrice, :UnitCost, :Weight, :Quantity, :LocalStatus, :IsManual, :TotalWeight, :created_at, :updated_at
json.url order_item_url(order_item, format: :json)
