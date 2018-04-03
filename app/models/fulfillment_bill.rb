require 'axlsx'
class FulfillmentBill < ApplicationRecord
  
  def description
    store_name + " to " + customer_name  
  end
  
  def customer_name
    if @customer_name.nil?
      customer = Customer.find(customer_id)
      @customer_name = customer.nil? ? 'Unknown' : customer.name
    end
    @customer_name
  end
  
  def save_to_xlsx(start_date, end_date)
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    bill_order_infos = get_bill_order_infos(@start_date, @end_date)
    p = Axlsx::Package.new

    # Required for use with numbers
    p.use_shared_strings = true
    
    p.workbook do |wb|
      # define your regular styles
      styles = wb.styles
      title = styles.add_style :sz => 15, :b => true, :u => true
      default = styles.add_style :border => Axlsx::STYLE_THIN_BORDER
      pascal_colors = { :bg_color => '567DCC', :fg_color => 'FFFF00' }
      pascal = styles.add_style pascal_colors.merge({ :border => Axlsx::STYLE_THIN_BORDER, :b => true })
      header = styles.add_style :bg_color => 'DDEAFF', :fg_color => '00', :b => true
      money = styles.add_style :format_code => '#,###,##0.00', :border => Axlsx::STYLE_THIN_BORDER
      money_pascal = styles.add_style pascal_colors.merge({ :format_code => '#,###,##0', :border => Axlsx::STYLE_THIN_BORDER })
      percent = styles.add_style :num_fmt => Axlsx::NUM_FMT_PERCENT, :border => Axlsx::STYLE_THIN_BORDER
      percent_pascal = styles.add_style pascal_colors.merge({ :num_fmt => Axlsx::NUM_FMT_PERCENT, :border => Axlsx::STYLE_THIN_BORDER })
      number = styles.add_style :format_code => '#', :border => Axlsx::STYLE_THIN_BORDER
    
      # generate the summary sheet
      wb.add_worksheet(:name => 'Order Summary') do |ws|
        ws.add_row ['Name','Description','SKU','Quantity'], :style => header
        bill_items = get_bill_items(@start_date, @end_date)
        bill_items.each do |bill_item|
          ws.add_row [bill_item.name,bill_item.description,bill_item.sku,bill_item.quantity,bill_item.price], 
            :style => [default, default, default, number, money]
        end
      end
      # generate the order items list sheet
      wb.add_worksheet(:name => 'Order Items') do |ws|
        ws.add_row ['Ordernumber','Orderdate','Localstatus','Shipment Cost','Item','SKU','Tracking'], :style => header
        bill_order_infos.each do |order|
          ws.add_row [order.order_number, order.order_date.to_s, order.status, order.shipment_cost,
            order.name,order.sku,"'"+order.tracking], :style => [default, default, default, money, default, default, number]
        end
        
      end
    end
    filename = store_name + ' ' + @end_date.strftime('%m-%d-%y')+'.xlsx'
    p.serialize filename
    filename
  end
  
  def get_bill_items(start_date, end_date)
      order_items = custom_sql.nil? ? OrderItem.shipped_by_range_counts(store_id,start_date,end_date)
        : OrderItem.shipped_by_range_counts_with_sql(store_id,start_date,end_date, custom_sql)
      bill_items = BillItem.generate_array(order_items)
      if include_fulfillment_charge then
        fulfillment_product = Product.find_by sku: "FULFILLMENT"
        uom = Uom.find_by id: fulfillment_product.uomId
        shipment_count = custom_fulfillment_sql.nil? ? Shipment.count_by_range(store_id,start_date,end_date)
          : Shipment.count_by_range_sql(store_id,start_date,end_date, custom_fulfillment_sql)
        bill_items << BillItem.new(fulfillment_product.num, fulfillment_product.num, fulfillment_product.sku, shipment_count, 
          fulfillment_product.price, uom.code)
      end
      if include_usps_charge then
        usps_product = Product.find_by sku: "USPS"
        uom = Uom.find_by id: usps_product.uomId
        usps_start_date = start_date-7
        usps_end_date = end_date-7
        usps_cost = Shipment.usps_cost_by_range(store_id,usps_start_date,usps_end_date)
        usps_count = custom_shipping_charge_sql.nil? ? Shipment.usps_count_by_range(store_id,usps_start_date,usps_end_date)
          : Shipment.usps_count_by_range_sql(store_id,usps_start_date,usps_end_date, custom_shipping_charge_sql)
        usps_description = "#{usps_product.num} Dates: #{start_date} to #{end_date} Count: #{usps_count}"
        bill_items << BillItem.new("USPS Shipping",usps_description, usps_product.sku, 1, usps_cost, uom.code)
      end    
      bill_items
  end
  
  def get_store_name
      store = Store.find(store_id)
      store.store_name    
  end
  
  def get_bill_order_infos(start_date, end_date)
    orders = custom_order_list_sql.nil? ? Order.shipped_by_range(store_id,start_date,end_date)
        : Order.shipped_by_range_sql(store_id,start_date,end_date,custom_order_list_sql)
    BillOrderInfo.generate_array(orders)    
  end
end
