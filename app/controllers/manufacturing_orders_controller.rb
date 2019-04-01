class ManufacturingOrdersController < ApplicationController
  before_action :set_manufacturing_order, only: [:show]

  # GET /manufacturing_orders
  # GET /manufacturing_orders.json
  def index
    @mos = ManufacturingOrder.default_data
  end

  # GET /manufacturing_orders/1
  # GET /manufacturing_orders/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manufacturing_order
      @mo = ManufacturingOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manufacturing_order_params
      params.require(:mo).permit(:RowVersion, :num, :dateScheduled, :statusId)
    end
end
