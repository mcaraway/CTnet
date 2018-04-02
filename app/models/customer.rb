class Customer < FishbowlDbBase
  self.table_name = "customer"
  self.primary_key = "id"
  
  def bill_to_xml
    # bill
  end
  
  def ship_to_xml
    Nokogiri::XML::Builder.new do |xml|
      xml.BillTo {
              xml.Name = :name unless sales_order[:bill_to][:name].nil?
              xml.AddressField sales_order[:bill_to][:address] unless sales_order[:bill_to][:address].nil?
              xml.City sales_order[:bill_to][:city] unless sales_order[:bill_to][:city].nil?
              xml.Zip sales_order[:bill_to][:zip] unless sales_order[:bill_to][:zip].nil?
              xml.Country sales_order[:bill_to][:country] unless sales_order[:bill_to][:country].nil?
              xml.State sales_order[:bill_to][:state] unless sales_order[:bill_to][:state].nil?
            }
    end
  end
end
