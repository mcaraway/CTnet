require 'test_helper'

class OrderItemAttributesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_item_attribute = order_item_attributes(:one)
  end

  test "should get index" do
    get order_item_attributes_url
    assert_response :success
  end

  test "should get new" do
    get new_order_item_attribute_url
    assert_response :success
  end

  test "should create order_item_attribute" do
    assert_difference('OrderItemAttribute.count') do
      post order_item_attributes_url, params: { order_item_attribute: { Description: @order_item_attribute.Description, IsManual: @order_item_attribute.IsManual, Name: @order_item_attribute.Name, OrderItemID: @order_item_attribute.OrderItemID, RowVersion: @order_item_attribute.RowVersion, UnitPrice: @order_item_attribute.UnitPrice } }
    end

    assert_redirected_to order_item_attribute_url(OrderItemAttribute.last)
  end

  test "should show order_item_attribute" do
    get order_item_attribute_url(@order_item_attribute)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_item_attribute_url(@order_item_attribute)
    assert_response :success
  end

  test "should update order_item_attribute" do
    patch order_item_attribute_url(@order_item_attribute), params: { order_item_attribute: { Description: @order_item_attribute.Description, IsManual: @order_item_attribute.IsManual, Name: @order_item_attribute.Name, OrderItemID: @order_item_attribute.OrderItemID, RowVersion: @order_item_attribute.RowVersion, UnitPrice: @order_item_attribute.UnitPrice } }
    assert_redirected_to order_item_attribute_url(@order_item_attribute)
  end

  test "should destroy order_item_attribute" do
    assert_difference('OrderItemAttribute.count', -1) do
      delete order_item_attribute_url(@order_item_attribute)
    end

    assert_redirected_to order_item_attributes_url
  end
end
