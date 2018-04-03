require 'logger'
class FulfillmentBillsController < ApplicationController
  before_action :set_fulfillment_bill, only: [:show, :edit, :update, :destroy, :refresh, :create_sales_order, :create_xlsx]
  before_action :preload_stores

  # GET /fulfillment_bills
  # GET /fulfillment_bills.json
  def index
    @fulfillment_bills = FulfillmentBill.all
  end

  # GET /fulfillment_bills/1
  # GET /fulfillment_bills/1.json
  def show
    @store = Store.find(@fulfillment_bill.store_id)
    @customer = get_customer(@fulfillment_bill.customer_id)
  end

  # GET /fulfillment_bills/new
  def new
    @fulfillment_bill = FulfillmentBill.new
  end

  # GET /fulfillment_bills/1/edit
  def edit
  end

  def refresh
    get_report(params[:start_date], params[:end_date])
    respond_to do |format|
      format.js {render layout: false} # Add this line to you respond_to block
    end
  end
  
  def create_sales_order 
    get_report(params[:start_date], params[:end_date])
    address = Address.find_by(accountId: @customer.accountId, typeId: 50)
    # puts("xml for customer #{@customer.to_xml(:skip_instruct => true, :except => [ :id ])}")
    sales_order = {}
    rows = []
    row = %Q["SO",,20,"#{@customer.name}","#{@customer.name}",#{address.to_string},#{address.to_string},"Will Call","None",30]
    rows << row
    # sales_order[:salesman] = "ctnet"
    # sales_order[:status] = 10
    # sales_order_items = Array.new
    @bill_items.each do |bill_item|
      rows << %Q["Item",10,"#{bill_item.name}","#{bill_item.description}",#{bill_item.quantity},"#{bill_item.uom}",#{bill_item.price}]
    end
    # sales_order[:items] = sales_order_items
    sales_order[:rows] = rows
    
    puts("Sending request for #{sales_order}")
    Fishbowl.configuration.debug = true
    Fishbowl::Requests.save_sales_order(sales_order)
    respond_to do |format|
      format.js {render layout: false}
    end
  end
  
  def create_xlsx
    filename = @fulfillment_bill.save_to_xlsx(params[:start_date], params[:end_date])
    send_file './'+filename, :filename => filename, :type => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      :disposition => 'attachment'
  end
  
  # POST /fulfillment_bills
  # POST /fulfillment_bills.json
  def create
    @fulfillment_bill = FulfillmentBill.new(fulfillment_bill_params)
    set_store_name
    
    respond_to do |format|
      if @fulfillment_bill.save
        format.html { redirect_to @fulfillment_bill, notice: 'Fulfillment bill was successfully created.' }
        format.json { render :show, status: :created, location: @fulfillment_bill }
      else
        format.html { render :new }
        format.json { render json: @fulfillment_bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fulfillment_bills/1
  # PATCH/PUT /fulfillment_bills/1.json
  def update
    attributes = fulfillment_bill_params.clone
    puts attributes
    @store = Store.find(attributes["store_id"])
    puts "Found Store = #{@store.StoreName}" if !@store.nil?
    attributes = attributes.merge("store_name" => @store.StoreName)
    puts attributes
    respond_to do |format|
      if @fulfillment_bill.update(attributes)
        format.html { redirect_to @fulfillment_bill, notice: 'Fulfillment bill was successfully updated.' }
        format.json { render :show, status: :ok, location: @fulfillment_bill }
      else
        format.html { render :edit }
        format.json { render json: @fulfillment_bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fulfillment_bills/1
  # DELETE /fulfillment_bills/1.json
  def destroy
    @fulfillment_bill.destroy
    respond_to do |format|
      format.html { redirect_to fulfillment_bills_url, notice: 'Fulfillment bill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def get_report(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @store = Store.find(@fulfillment_bill.store_id)
      @customer = get_customer(@fulfillment_bill.customer_id)
      @orders = @fulfillment_bill.custom_order_list_sql.nil? ? Order.shipped_by_range(@fulfillment_bill.store_id,@start_date,@end_date,params[:page],20)
        : Order.shipped_by_range_sql(@fulfillment_bill.store_id,@start_date,@end_date,@fulfillment_bill.custom_order_list_sql,params[:page],20)
      @bill_order_infos = BillOrderInfo.generate_array(@orders)
      @bill_items = @fulfillment_bill.get_bill_items(@start_date, @end_date)
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_fulfillment_bill
      @fulfillment_bill = FulfillmentBill.find(params[:id])
    end

    def get_customer (id)
      @customers.find(id)
    end
     
    def set_store_name
      @store = Store.find(@fulfillment_bill.store_id)
      @fulfillment_bill.store_name = @store.StoreName
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def fulfillment_bill_params
      params.require(:fulfillment_bill).permit(:store_name, :start_date, :end_date, :store_id, :customer_id, :include_fulfillment_charge, :include_usps_charge, :custom_sql,:custom_fulfillment_sql,:custom_shipping_charge_sql, :custom_order_list_sql)
    end
    
    def preload_stores
      @stores = Store.all_cached
      @customers = Customer.all
    end
end
