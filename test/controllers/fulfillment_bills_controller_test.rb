require 'test_helper'

class FulfillmentBillsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fulfillment_bill = fulfillment_bills(:one)
  end

  test "should get index" do
    get fulfillment_bills_url
    assert_response :success
  end

  test "should get new" do
    get new_fulfillment_bill_url
    assert_response :success
  end

  test "should create fulfillment_bill" do
    assert_difference('FulfillmentBill.count') do
      post fulfillment_bills_url, params: { fulfillment_bill: { end_date: @fulfillment_bill.end_date, start_date: @fulfillment_bill.start_date, store_name: @fulfillment_bill.store_name } }
    end

    assert_redirected_to fulfillment_bill_url(FulfillmentBill.last)
  end

  test "should show fulfillment_bill" do
    get fulfillment_bill_url(@fulfillment_bill)
    assert_response :success
  end

  test "should get edit" do
    get edit_fulfillment_bill_url(@fulfillment_bill)
    assert_response :success
  end

  test "should update fulfillment_bill" do
    patch fulfillment_bill_url(@fulfillment_bill), params: { fulfillment_bill: { end_date: @fulfillment_bill.end_date, start_date: @fulfillment_bill.start_date, store_name: @fulfillment_bill.store_name } }
    assert_redirected_to fulfillment_bill_url(@fulfillment_bill)
  end

  test "should destroy fulfillment_bill" do
    assert_difference('FulfillmentBill.count', -1) do
      delete fulfillment_bill_url(@fulfillment_bill)
    end

    assert_redirected_to fulfillment_bills_url
  end
end
