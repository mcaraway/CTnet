require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: { order: { BillAddressValidationError: @order.BillAddressValidationError, BillAddressValidationStatus: @order.BillAddressValidationStatus, BillAddressValidationSuggestionCount: @order.BillAddressValidationSuggestionCount, BillCity: @order.BillCity, BillCompany: @order.BillCompany, BillCountryCode: @order.BillCountryCode, BillEmail: @order.BillEmail, BillFax: @order.BillFax, BillFirstName: @order.BillFirstName, BillLastName: @order.BillLastName, BillMiddleName: @order.BillMiddleName, BillMilitaryAddress: @order.BillMilitaryAddress, BillNameParseStatus: @order.BillNameParseStatus, BillPOBox: @order.BillPOBox, BillPhone: @order.BillPhone, BillPostalCode: @order.BillPostalCode, BillResidentialStatus: @order.BillResidentialStatus, BillStateProvCode: @order.BillStateProvCode, BillStreet1: @order.BillStreet1, BillStreet2: @order.BillStreet2, BillStreet3: @order.BillStreet3, BillUSTerritory: @order.BillUSTerritory, BillUnparsedName: @order.BillUnparsedName, BillWebsite: @order.BillWebsite, CustomerID: @order.CustomerID, IsManual: @order.IsManual, LocalStatus: @order.LocalStatus, OnlineCustomerID: @order.OnlineCustomerID, OnlineLastModified: @order.OnlineLastModified, OnlineStatus: @order.OnlineStatus, OnlineStatusCode: @order.OnlineStatusCode, OrderDate: @order.OrderDate, OrderNumber: @order.OrderNumber, OrderNumberComplete: @order.OrderNumberComplete, OrderTotal: @order.OrderTotal, RequestedShipping: @order.RequestedShipping, RollupItemCode: @order.RollupItemCode, RollupItemCount: @order.RollupItemCount, RollupItemLocation: @order.RollupItemLocation, RollupItemName: @order.RollupItemName, RollupItemQuantity: @order.RollupItemQuantity, RollupItemSKU: @order.RollupItemSKU, RollupItemTotalWeight: @order.RollupItemTotalWeight, RollupNoteCount: @order.RollupNoteCount, RowVersion: @order.RowVersion, ShipAddressType: @order.ShipAddressType, ShipAddressValidationError: @order.ShipAddressValidationError, ShipAddressValidationStatus: @order.ShipAddressValidationStatus, ShipAddressValidationSuggestionCount: @order.ShipAddressValidationSuggestionCount, ShipCity: @order.ShipCity, ShipCompany: @order.ShipCompany, ShipCountryCode: @order.ShipCountryCode, ShipEmail: @order.ShipEmail, ShipFax: @order.ShipFax, ShipFirstName: @order.ShipFirstName, ShipLastName: @order.ShipLastName, ShipMiddleName: @order.ShipMiddleName, ShipMilitaryAddress: @order.ShipMilitaryAddress, ShipNameParseStatus: @order.ShipNameParseStatus, ShipPOBox: @order.ShipPOBox, ShipPhone: @order.ShipPhone, ShipPostalCode: @order.ShipPostalCode, ShipResidentialStatus: @order.ShipResidentialStatus, ShipSenseHashKey: @order.ShipSenseHashKey, ShipSenseRecognitionStatus: @order.ShipSenseRecognitionStatus, ShipStateProvCode: @order.ShipStateProvCode, ShipStreet1: @order.ShipStreet1, ShipStreet2: @order.ShipStreet2, ShipStreet3: @order.ShipStreet3, ShipUSTerritory: @order.ShipUSTerritory, ShipUnparsedName: @order.ShipUnparsedName, ShipWebsite: @order.ShipWebsite, StoreID: @order.StoreID } }
    end

    assert_redirected_to order_url(Order.last)
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: { BillAddressValidationError: @order.BillAddressValidationError, BillAddressValidationStatus: @order.BillAddressValidationStatus, BillAddressValidationSuggestionCount: @order.BillAddressValidationSuggestionCount, BillCity: @order.BillCity, BillCompany: @order.BillCompany, BillCountryCode: @order.BillCountryCode, BillEmail: @order.BillEmail, BillFax: @order.BillFax, BillFirstName: @order.BillFirstName, BillLastName: @order.BillLastName, BillMiddleName: @order.BillMiddleName, BillMilitaryAddress: @order.BillMilitaryAddress, BillNameParseStatus: @order.BillNameParseStatus, BillPOBox: @order.BillPOBox, BillPhone: @order.BillPhone, BillPostalCode: @order.BillPostalCode, BillResidentialStatus: @order.BillResidentialStatus, BillStateProvCode: @order.BillStateProvCode, BillStreet1: @order.BillStreet1, BillStreet2: @order.BillStreet2, BillStreet3: @order.BillStreet3, BillUSTerritory: @order.BillUSTerritory, BillUnparsedName: @order.BillUnparsedName, BillWebsite: @order.BillWebsite, CustomerID: @order.CustomerID, IsManual: @order.IsManual, LocalStatus: @order.LocalStatus, OnlineCustomerID: @order.OnlineCustomerID, OnlineLastModified: @order.OnlineLastModified, OnlineStatus: @order.OnlineStatus, OnlineStatusCode: @order.OnlineStatusCode, OrderDate: @order.OrderDate, OrderNumber: @order.OrderNumber, OrderNumberComplete: @order.OrderNumberComplete, OrderTotal: @order.OrderTotal, RequestedShipping: @order.RequestedShipping, RollupItemCode: @order.RollupItemCode, RollupItemCount: @order.RollupItemCount, RollupItemLocation: @order.RollupItemLocation, RollupItemName: @order.RollupItemName, RollupItemQuantity: @order.RollupItemQuantity, RollupItemSKU: @order.RollupItemSKU, RollupItemTotalWeight: @order.RollupItemTotalWeight, RollupNoteCount: @order.RollupNoteCount, RowVersion: @order.RowVersion, ShipAddressType: @order.ShipAddressType, ShipAddressValidationError: @order.ShipAddressValidationError, ShipAddressValidationStatus: @order.ShipAddressValidationStatus, ShipAddressValidationSuggestionCount: @order.ShipAddressValidationSuggestionCount, ShipCity: @order.ShipCity, ShipCompany: @order.ShipCompany, ShipCountryCode: @order.ShipCountryCode, ShipEmail: @order.ShipEmail, ShipFax: @order.ShipFax, ShipFirstName: @order.ShipFirstName, ShipLastName: @order.ShipLastName, ShipMiddleName: @order.ShipMiddleName, ShipMilitaryAddress: @order.ShipMilitaryAddress, ShipNameParseStatus: @order.ShipNameParseStatus, ShipPOBox: @order.ShipPOBox, ShipPhone: @order.ShipPhone, ShipPostalCode: @order.ShipPostalCode, ShipResidentialStatus: @order.ShipResidentialStatus, ShipSenseHashKey: @order.ShipSenseHashKey, ShipSenseRecognitionStatus: @order.ShipSenseRecognitionStatus, ShipStateProvCode: @order.ShipStateProvCode, ShipStreet1: @order.ShipStreet1, ShipStreet2: @order.ShipStreet2, ShipStreet3: @order.ShipStreet3, ShipUSTerritory: @order.ShipUSTerritory, ShipUnparsedName: @order.ShipUnparsedName, ShipWebsite: @order.ShipWebsite, StoreID: @order.StoreID } }
    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
