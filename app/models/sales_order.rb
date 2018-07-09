class SalesOrder < FishbowlDbBase
  self.table_name = "so"
  self.primary_key = "id"
  
    class << self
      def by_customer_id(customer_id)
        SalesOrder.where("customerId = ?", customer_id)
          .order("dateIssued desc")
      end
    end
end
