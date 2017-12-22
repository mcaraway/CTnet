class OrderItemAttributesController < ApplicationController
  before_action :set_order_item_attribute, only: [:show, :edit, :update, :destroy]

  # GET /order_item_attributes
  # GET /order_item_attributes.json
  def index
    @order_item_attributes = OrderItemAttribute.all
  end

  # GET /order_item_attributes/1
  # GET /order_item_attributes/1.json
  def show
  end

  # GET /order_item_attributes/new
  def new
    @order_item_attribute = OrderItemAttribute.new
  end

  # GET /order_item_attributes/1/edit
  def edit
  end

  # POST /order_item_attributes
  # POST /order_item_attributes.json
  def create
    @order_item_attribute = OrderItemAttribute.new(order_item_attribute_params)

    respond_to do |format|
      if @order_item_attribute.save
        format.html { redirect_to @order_item_attribute, notice: 'Order item attribute was successfully created.' }
        format.json { render :show, status: :created, location: @order_item_attribute }
      else
        format.html { render :new }
        format.json { render json: @order_item_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_item_attributes/1
  # PATCH/PUT /order_item_attributes/1.json
  def update
    respond_to do |format|
      if @order_item_attribute.update(order_item_attribute_params)
        format.html { redirect_to @order_item_attribute, notice: 'Order item attribute was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_item_attribute }
      else
        format.html { render :edit }
        format.json { render json: @order_item_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_item_attributes/1
  # DELETE /order_item_attributes/1.json
  def destroy
    @order_item_attribute.destroy
    respond_to do |format|
      format.html { redirect_to order_item_attributes_url, notice: 'Order item attribute was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_item_attribute
      @order_item_attribute = OrderItemAttribute.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_item_attribute_params
      params.require(:order_item_attribute).permit(:RowVersion, :OrderItemID, :Name, :Description, :UnitPrice, :IsManual)
    end
end
