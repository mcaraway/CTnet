class ShipmentsController < ApplicationController
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]

  # GET /shipments
  # GET /shipments.json
  def index
    @shipments = Shipment.all
  end

  # GET /shipments/1
  # GET /shipments/1.json
  def show
  end

  # GET /shipments/new
  def new
    @shipment = Shipment.new
  end

  # GET /shipments/1/edit
  def edit
  end

  # POST /shipments
  # POST /shipments.json
  def create
    @shipment = Shipment.new(shipment_params)

    respond_to do |format|
      if @shipment.save
        format.html { redirect_to @shipment, notice: 'Shipment was successfully created.' }
        format.json { render :show, status: :created, location: @shipment }
      else
        format.html { render :new }
        format.json { render json: @shipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipments/1
  # PATCH/PUT /shipments/1.json
  def update
    respond_to do |format|
      if @shipment.update(shipment_params)
        format.html { redirect_to @shipment, notice: 'Shipment was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipment }
      else
        format.html { render :edit }
        format.json { render json: @shipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipments/1
  # DELETE /shipments/1.json
  def destroy
    @shipment.destroy
    respond_to do |format|
      format.html { redirect_to shipments_url, notice: 'Shipment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipment
      @shipment = Shipment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipment_params
      params.require(:shipment).permit(:RowVersion, :OrderID, :ShipmentType, :ContentWeight, :TotalWeight, :Processed, :ProcessedDate, :ProcessedUserID, :ProcessedComputerID, :ShipDate, :ShipmentCost, :Voided, :VoidedDate, :VoidedUserID, :VoidedComputerID, :TrackingNumber, :CustomsGenerated, :CustomsValue, :RequestedLabelFormat, :ActualLabelFormat, :ShipFirstName, :ShipMiddleName, :ShipLastName, :ShipCompany, :ShipStreet1, :ShipStreet2, :ShipStreet3, :ShipCity, :ShipStateProvCode, :ShipPostalCode, :ShipCountryCode, :ShipPhone, :ShipEmail, :ShipAddressValidationSuggestionCount, :ShipAddressValidationStatus, :ShipAddressValidationError, :ShipResidentialStatus, :ShipPOBox, :ShipUSTerritory, :ShipMilitaryAddress, :ResidentialDetermination, :ResidentialResult, :OriginOriginID, :OriginFirstName, :OriginMiddleName, :OriginLastName, :OriginCompany, :OriginStreet1, :OriginStreet2, :OriginStreet3, :OriginCity, :OriginStateProvCode, :OriginPostalCode, :OriginCountryCode, :OriginPhone, :OriginFax, :OriginEmail, :OriginWebsite, :ReturnShipment, :Insurance, :InsuranceProvider, :ShipNameParseStatus, :ShipUnparsedName, :OriginNameParseStatus, :OriginUnparsedName, :BestRateEvents, :ShipSenseStatus, :ShipSenseChangeSets, :ShipSenseEntry, :OnlineShipmentID, :BilledType, :BilledWeight)
    end
end
