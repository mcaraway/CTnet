class SalesOrder < FishbowlDbBase
  self.table_name = "so"
  self.primary_key = "id"
  has_one :customer, foreign_key: "id", primary_key: "customerId"
  
    class << self
      def by_customer_id(customer_id)
        SalesOrder.where("customerId = ?", customer_id)
          .order("dateIssued desc")
      end
    end
end
