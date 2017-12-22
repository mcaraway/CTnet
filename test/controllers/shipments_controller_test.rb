require 'test_helper'

class ShipmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shipment = shipments(:one)
  end

  test "should get index" do
    get shipments_url
    assert_response :success
  end

  test "should get new" do
    get new_shipment_url
    assert_response :success
  end

  test "should create shipment" do
    assert_difference('Shipment.count') do
      post shipments_url, params: { shipment: { ActualLabelFormat: @shipment.ActualLabelFormat, BestRateEvents: @shipment.BestRateEvents, BilledType: @shipment.BilledType, BilledWeight: @shipment.BilledWeight, ContentWeight: @shipment.ContentWeight, CustomsGenerated: @shipment.CustomsGenerated, CustomsValue: @shipment.CustomsValue, Insurance: @shipment.Insurance, InsuranceProvider: @shipment.InsuranceProvider, OnlineShipmentID: @shipment.OnlineShipmentID, OrderID: @shipment.OrderID, OriginCity: @shipment.OriginCity, OriginCompany: @shipment.OriginCompany, OriginCountryCode: @shipment.OriginCountryCode, OriginEmail: @shipment.OriginEmail, OriginFax: @shipment.OriginFax, OriginFirstName: @shipment.OriginFirstName, OriginLastName: @shipment.OriginLastName, OriginMiddleName: @shipment.OriginMiddleName, OriginNameParseStatus: @shipment.OriginNameParseStatus, OriginOriginID: @shipment.OriginOriginID, OriginPhone: @shipment.OriginPhone, OriginPostalCode: @shipment.OriginPostalCode, OriginStateProvCode: @shipment.OriginStateProvCode, OriginStreet1: @shipment.OriginStreet1, OriginStreet2: @shipment.OriginStreet2, OriginStreet3: @shipment.OriginStreet3, OriginUnparsedName: @shipment.OriginUnparsedName, OriginWebsite: @shipment.OriginWebsite, Processed: @shipment.Processed, ProcessedComputerID: @shipment.ProcessedComputerID, ProcessedDate: @shipment.ProcessedDate, ProcessedUserID: @shipment.ProcessedUserID, RequestedLabelFormat: @shipment.RequestedLabelFormat, ResidentialDetermination: @shipment.ResidentialDetermination, ResidentialResult: @shipment.ResidentialResult, ReturnShipment: @shipment.ReturnShipment, RowVersion: @shipment.RowVersion, ShipAddressValidationError: @shipment.ShipAddressValidationError, ShipAddressValidationStatus: @shipment.ShipAddressValidationStatus, ShipAddressValidationSuggestionCount: @shipment.ShipAddressValidationSuggestionCount, ShipCity: @shipment.ShipCity, ShipCompany: @shipment.ShipCompany, ShipCountryCode: @shipment.ShipCountryCode, ShipDate: @shipment.ShipDate, ShipEmail: @shipment.ShipEmail, ShipFirstName: @shipment.ShipFirstName, ShipLastName: @shipment.ShipLastName, ShipMiddleName: @shipment.ShipMiddleName, ShipMilitaryAddress: @shipment.ShipMilitaryAddress, ShipNameParseStatus: @shipment.ShipNameParseStatus, ShipPOBox: @shipment.ShipPOBox, ShipPhone: @shipment.ShipPhone, ShipPostalCode: @shipment.ShipPostalCode, ShipResidentialStatus: @shipment.ShipResidentialStatus, ShipSenseChangeSets: @shipment.ShipSenseChangeSets, ShipSenseEntry: @shipment.ShipSenseEntry, ShipSenseStatus: @shipment.ShipSenseStatus, ShipStateProvCode: @shipment.ShipStateProvCode, ShipStreet1: @shipment.ShipStreet1, ShipStreet2: @shipment.ShipStreet2, ShipStreet3: @shipment.ShipStreet3, ShipUSTerritory: @shipment.ShipUSTerritory, ShipUnparsedName: @shipment.ShipUnparsedName, ShipmentCost: @shipment.ShipmentCost, ShipmentType: @shipment.ShipmentType, TotalWeight: @shipment.TotalWeight, TrackingNumber: @shipment.TrackingNumber, Voided: @shipment.Voided, VoidedComputerID: @shipment.VoidedComputerID, VoidedDate: @shipment.VoidedDate, VoidedUserID: @shipment.VoidedUserID } }
    end

    assert_redirected_to shipment_url(Shipment.last)
  end

  test "should show shipment" do
    get shipment_url(@shipment)
    assert_response :success
  end

  test "should get edit" do
    get edit_shipment_url(@shipment)
    assert_response :success
  end

  test "should update shipment" do
    patch shipment_url(@shipment), params: { shipment: { ActualLabelFormat: @shipment.ActualLabelFormat, BestRateEvents: @shipment.BestRateEvents, BilledType: @shipment.BilledType, BilledWeight: @shipment.BilledWeight, ContentWeight: @shipment.ContentWeight, CustomsGenerated: @shipment.CustomsGenerated, CustomsValue: @shipment.CustomsValue, Insurance: @shipment.Insurance, InsuranceProvider: @shipment.InsuranceProvider, OnlineShipmentID: @shipment.OnlineShipmentID, OrderID: @shipment.OrderID, OriginCity: @shipment.OriginCity, OriginCompany: @shipment.OriginCompany, OriginCountryCode: @shipment.OriginCountryCode, OriginEmail: @shipment.OriginEmail, OriginFax: @shipment.OriginFax, OriginFirstName: @shipment.OriginFirstName, OriginLastName: @shipment.OriginLastName, OriginMiddleName: @shipment.OriginMiddleName, OriginNameParseStatus: @shipment.OriginNameParseStatus, OriginOriginID: @shipment.OriginOriginID, OriginPhone: @shipment.OriginPhone, OriginPostalCode: @shipment.OriginPostalCode, OriginStateProvCode: @shipment.OriginStateProvCode, OriginStreet1: @shipment.OriginStreet1, OriginStreet2: @shipment.OriginStreet2, OriginStreet3: @shipment.OriginStreet3, OriginUnparsedName: @shipment.OriginUnparsedName, OriginWebsite: @shipment.OriginWebsite, Processed: @shipment.Processed, ProcessedComputerID: @shipment.ProcessedComputerID, ProcessedDate: @shipment.ProcessedDate, ProcessedUserID: @shipment.ProcessedUserID, RequestedLabelFormat: @shipment.RequestedLabelFormat, ResidentialDetermination: @shipment.ResidentialDetermination, ResidentialResult: @shipment.ResidentialResult, ReturnShipment: @shipment.ReturnShipment, RowVersion: @shipment.RowVersion, ShipAddressValidationError: @shipment.ShipAddressValidationError, ShipAddressValidationStatus: @shipment.ShipAddressValidationStatus, ShipAddressValidationSuggestionCount: @shipment.ShipAddressValidationSuggestionCount, ShipCity: @shipment.ShipCity, ShipCompany: @shipment.ShipCompany, ShipCountryCode: @shipment.ShipCountryCode, ShipDate: @shipment.ShipDate, ShipEmail: @shipment.ShipEmail, ShipFirstName: @shipment.ShipFirstName, ShipLastName: @shipment.ShipLastName, ShipMiddleName: @shipment.ShipMiddleName, ShipMilitaryAddress: @shipment.ShipMilitaryAddress, ShipNameParseStatus: @shipment.ShipNameParseStatus, ShipPOBox: @shipment.ShipPOBox, ShipPhone: @shipment.ShipPhone, ShipPostalCode: @shipment.ShipPostalCode, ShipResidentialStatus: @shipment.ShipResidentialStatus, ShipSenseChangeSets: @shipment.ShipSenseChangeSets, ShipSenseEntry: @shipment.ShipSenseEntry, ShipSenseStatus: @shipment.ShipSenseStatus, ShipStateProvCode: @shipment.ShipStateProvCode, ShipStreet1: @shipment.ShipStreet1, ShipStreet2: @shipment.ShipStreet2, ShipStreet3: @shipment.ShipStreet3, ShipUSTerritory: @shipment.ShipUSTerritory, ShipUnparsedName: @shipment.ShipUnparsedName, ShipmentCost: @shipment.ShipmentCost, ShipmentType: @shipment.ShipmentType, TotalWeight: @shipment.TotalWeight, TrackingNumber: @shipment.TrackingNumber, Voided: @shipment.Voided, VoidedComputerID: @shipment.VoidedComputerID, VoidedDate: @shipment.VoidedDate, VoidedUserID: @shipment.VoidedUserID } }
    assert_redirected_to shipment_url(@shipment)
  end

  test "should destroy shipment" do
    assert_difference('Shipment.count', -1) do
      delete shipment_url(@shipment)
    end

    assert_redirected_to shipments_url
  end
end
