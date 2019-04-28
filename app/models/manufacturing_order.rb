class ManufacturingOrder < FishbowlDbBase
  self.table_name = "mo"
  self.primary_key = "id"
  has_one :sales_order, foreign_key: "id", primary_key: "soId"
  has_one :mo_status, foreign_key: "id", primary_key: "statusId"
  
  class << self
    def find_as_mo(id)
        ManufacturingOrder.select("mo.id, mo.dateScheduled, mo.num as monum, so.num as sonum, so.note, mostatus.name as status, customer.name as cust_name")
          .joins(:mo_status)
          .joins("left outer join so on so.id = mo.soId")
          .joins("left outer join customer on so.customerId = customer.id")
          .where("mo.id=?", id)
    end
    def default_data(page = 1, per_page = 100)
        ManufacturingOrder.select("mo.id, mo.dateScheduled, mo.num as monum, so.num as sonum, so.note, mostatus.name as status, customer.name as cust_name")
          .joins(:mo_status)
          .joins("left outer join so on so.id = mo.soId")
          .joins("left outer join customer on so.customerId = customer.id")
          .where("mostatus.id in (10,20,50)")
          .order("dateScheduled asc")
          .paginate(:page => page, :per_page => per_page)
    end
  end
end
