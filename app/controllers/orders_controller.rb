class OrdersController < ApplicationController
  before_action :set_order, only: [:show]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:RowVersion, :StoreID, :CustomerID, :OrderNumber, :OrderNumberComplete, :OrderDate, :OrderTotal, :LocalStatus, :IsManual, :OnlineLastModified, :OnlineCustomerID, :OnlineStatus, :OnlineStatusCode, :RequestedShipping, :BillFirstName, :BillMiddleName, :BillLastName, :BillCompany, :BillStreet1, :BillStreet2, :BillStreet3, :BillCity, :BillStateProvCode, :BillPostalCode, :BillCountryCode, :BillPhone, :BillFax, :BillEmail, :BillWebsite, :BillAddressValidationSuggestionCount, :BillAddressValidationStatus, :BillAddressValidationError, :BillResidentialStatus, :BillPOBox, :BillUSTerritory, :BillMilitaryAddress, :ShipFirstName, :ShipMiddleName, :ShipLastName, :ShipCompany, :ShipStreet1, :ShipStreet2, :ShipStreet3, :ShipCity, :ShipStateProvCode, :ShipPostalCode, :ShipCountryCode, :ShipPhone, :ShipFax, :ShipEmail, :ShipWebsite, :ShipAddressValidationSuggestionCount, :ShipAddressValidationStatus, :ShipAddressValidationError, :ShipResidentialStatus, :ShipPOBox, :ShipUSTerritory, :ShipMilitaryAddress, :RollupItemCount, :RollupItemName, :RollupItemCode, :RollupItemSKU, :RollupItemLocation, :RollupItemQuantity, :RollupItemTotalWeight, :RollupNoteCount, :BillNameParseStatus, :BillUnparsedName, :ShipNameParseStatus, :ShipUnparsedName, :ShipSenseHashKey, :ShipSenseRecognitionStatus, :ShipAddressType)
    end
end
