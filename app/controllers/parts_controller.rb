class PartsController < ApplicationController
  before_action :set_part, only: [:show]

  # GET /parts
  # GET /parts.json
  def index
    @parts = Part.paginate(:page => params[:page], :per_page => 50)
  end

  # GET /parts/1
  # GET /parts/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_Part
      @Part = Part.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def Part_params
      params.require(:Part).permit(:RowVersion, :StoreID, :CustomerID, :PartNumber, :PartNumberComplete, :PartDate, :PartTotal, :LocalStatus, :IsManual, :OnlineLastModified, :OnlineCustomerID, :OnlineStatus, :OnlineStatusCode, :RequestedShipping, :BillFirstName, :BillMiddleName, :BillLastName, :BillCompany, :BillStreet1, :BillStreet2, :BillStreet3, :BillCity, :BillStateProvCode, :BillPostalCode, :BillCountryCode, :BillPhone, :BillFax, :BillEmail, :BillWebsite, :BillAddressValidationSuggestionCount, :BillAddressValidationStatus, :BillAddressValidationError, :BillResidentialStatus, :BillPOBox, :BillUSTerritory, :BillMilitaryAddress, :ShipFirstName, :ShipMiddleName, :ShipLastName, :ShipCompany, :ShipStreet1, :ShipStreet2, :ShipStreet3, :ShipCity, :ShipStateProvCode, :ShipPostalCode, :ShipCountryCode, :ShipPhone, :ShipFax, :ShipEmail, :ShipWebsite, :ShipAddressValidationSuggestionCount, :ShipAddressValidationStatus, :ShipAddressValidationError, :ShipResidentialStatus, :ShipPOBox, :ShipUSTerritory, :ShipMilitaryAddress, :RollupItemCount, :RollupItemName, :RollupItemCode, :RollupItemSKU, :RollupItemLocation, :RollupItemQuantity, :RollupItemTotalWeight, :RollupNoteCount, :BillNameParseStatus, :BillUnparsedName, :ShipNameParseStatus, :ShipUnparsedName, :ShipSenseHashKey, :ShipSenseRecognitionStatus, :ShipAddressType)
    end
end
