require 'logger'
class FulfillmentBillsController < ApplicationController
  before_action :set_fulfillment_bill, only: [:show, :edit, :update, :destroy]
  before_action :preload_stores

  # GET /fulfillment_bills
  # GET /fulfillment_bills.json
  def index
    @fulfillment_bills = FulfillmentBill.all
  end

  # GET /fulfillment_bills/1
  # GET /fulfillment_bills/1.json
  def show
    @store = Store.find(@fulfillment_bill.store_name)
    @order_item_counts = OrderItem.shipped_by_range_counts(@fulfillment_bill.store_name,@fulfillment_bill.start_date,@fulfillment_bill.end_date)
    @orders = Order.shipped_by_range(@fulfillment_bill.store_name,@fulfillment_bill.start_date,@fulfillment_bill.end_date)
      .paginate(:page => params[:page], :per_page => 50)
  end

  # GET /fulfillment_bills/new
  def new
    @fulfillment_bill = FulfillmentBill.new
  end

  # GET /fulfillment_bills/1/edit
  def edit
  end

  # POST /fulfillment_bills
  # POST /fulfillment_bills.json
  def create
    @fulfillment_bill = FulfillmentBill.new(fulfillment_bill_params)

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
    respond_to do |format|
      if @fulfillment_bill.update(fulfillment_bill_params)
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
    # Use callbacks to share common setup or constraints between actions.
    def set_fulfillment_bill
      @fulfillment_bill = FulfillmentBill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fulfillment_bill_params
      params.require(:fulfillment_bill).permit(:store_name, :start_date, :end_date)
    end
    
    def preload_stores
      @stores = Store.all_cached
    end
end
