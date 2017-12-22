require 'test_helper'

class StoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @store = stores(:one)
  end

  test "should get index" do
    get stores_url
    assert_response :success
  end

  test "should get new" do
    get new_store_url
    assert_response :success
  end

  test "should create store" do
    assert_difference('Store.count') do
      post stores_url, params: { store: { AddressValidationSetting: @store.AddressValidationSetting, AutoDownload: @store.AutoDownload, AutoDownloadMinutes: @store.AutoDownloadMinutes, AutoDownloadOnlyAway: @store.AutoDownloadOnlyAway, City: @store.City, Company: @store.Company, ComputerDownloadPolicy: @store.ComputerDownloadPolicy, CountryCode: @store.CountryCode, DefaultEmailAccountID: @store.DefaultEmailAccountID, Edition: @store.Edition, Email: @store.Email, Enabled: @store.Enabled, Fax: @store.Fax, InitialDownloadDays: @store.InitialDownloadDays, InitialDownloadOrder: @store.InitialDownloadOrder, License: @store.License, ManualOrderPostfix: @store.ManualOrderPostfix, ManualOrderPrefix: @store.ManualOrderPrefix, Phone: @store.Phone, PostalCode: @store.PostalCode, RowVersion: @store.RowVersion, SetupComplete: @store.SetupComplete, StateProvCode: @store.StateProvCode, StoreName: @store.StoreName, Street1: @store.Street1, Street2: @store.Street2, Street3: @store.Street3, TypeCode: @store.TypeCode, Website: @store.Website } }
    end

    assert_redirected_to store_url(Store.last)
  end

  test "should show store" do
    get store_url(@store)
    assert_response :success
  end

  test "should get edit" do
    get edit_store_url(@store)
    assert_response :success
  end

  test "should update store" do
    patch store_url(@store), params: { store: { AddressValidationSetting: @store.AddressValidationSetting, AutoDownload: @store.AutoDownload, AutoDownloadMinutes: @store.AutoDownloadMinutes, AutoDownloadOnlyAway: @store.AutoDownloadOnlyAway, City: @store.City, Company: @store.Company, ComputerDownloadPolicy: @store.ComputerDownloadPolicy, CountryCode: @store.CountryCode, DefaultEmailAccountID: @store.DefaultEmailAccountID, Edition: @store.Edition, Email: @store.Email, Enabled: @store.Enabled, Fax: @store.Fax, InitialDownloadDays: @store.InitialDownloadDays, InitialDownloadOrder: @store.InitialDownloadOrder, License: @store.License, ManualOrderPostfix: @store.ManualOrderPostfix, ManualOrderPrefix: @store.ManualOrderPrefix, Phone: @store.Phone, PostalCode: @store.PostalCode, RowVersion: @store.RowVersion, SetupComplete: @store.SetupComplete, StateProvCode: @store.StateProvCode, StoreName: @store.StoreName, Street1: @store.Street1, Street2: @store.Street2, Street3: @store.Street3, TypeCode: @store.TypeCode, Website: @store.Website } }
    assert_redirected_to store_url(@store)
  end

  test "should destroy store" do
    assert_difference('Store.count', -1) do
      delete store_url(@store)
    end

    assert_redirected_to stores_url
  end
end
