require 'test_helper'

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_item = order_items(:one)
  end

  test "should get index" do
    get order_items_url
    assert_response :success
  end

  test "should get new" do
    get new_order_item_url
    assert_response :success
  end

  test "should create order_item" do
    assert_difference('OrderItem.count') do
      post order_items_url, params: { order_item: { Code: @order_item.Code, Description: @order_item.Description, ISBN: @order_item.ISBN, Image: @order_item.Image, IsManual: @order_item.IsManual, LocalStatus: @order_item.LocalStatus, Location: @order_item.Location, Name: @order_item.Name, OrderID: @order_item.OrderID, Quantity: @order_item.Quantity, RowVersion: @order_item.RowVersion, SKU: @order_item.SKU, Thumbnail: @order_item.Thumbnail, TotalWeight: @order_item.TotalWeight, UPC: @order_item.UPC, UnitCost: @order_item.UnitCost, UnitPrice: @order_item.UnitPrice, Weight: @order_item.Weight } }
    end

    assert_redirected_to order_item_url(OrderItem.last)
  end

  test "should show order_item" do
    get order_item_url(@order_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_item_url(@order_item)
    assert_response :success
  end

  test "should update order_item" do
    patch order_item_url(@order_item), params: { order_item: { Code: @order_item.Code, Description: @order_item.Description, ISBN: @order_item.ISBN, Image: @order_item.Image, IsManual: @order_item.IsManual, LocalStatus: @order_item.LocalStatus, Location: @order_item.Location, Name: @order_item.Name, OrderID: @order_item.OrderID, Quantity: @order_item.Quantity, RowVersion: @order_item.RowVersion, SKU: @order_item.SKU, Thumbnail: @order_item.Thumbnail, TotalWeight: @order_item.TotalWeight, UPC: @order_item.UPC, UnitCost: @order_item.UnitCost, UnitPrice: @order_item.UnitPrice, Weight: @order_item.Weight } }
    assert_redirected_to order_item_url(@order_item)
  end

  test "should destroy order_item" do
    assert_difference('OrderItem.count', -1) do
      delete order_item_url(@order_item)
    end

    assert_redirected_to order_items_url
  end
end
