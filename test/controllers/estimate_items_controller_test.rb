require 'test_helper'

class EstimateItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @estimate_item = estimate_items(:one)
  end

  test "should get index" do
    get estimate_items_url
    assert_response :success
  end

  test "should get new" do
    get new_estimate_item_url
    assert_response :success
  end

  test "should create estimate_item" do
    assert_difference('EstimateItem.count') do
      post estimate_items_url, params: { estimate_item: { amount: @estimate_item.amount, name: @estimate_item.name, option_group_id: @estimate_item.option_group_id, part_id: @estimate_item.part_id } }
    end

    assert_redirected_to estimate_item_url(EstimateItem.last)
  end

  test "should show estimate_item" do
    get estimate_item_url(@estimate_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_estimate_item_url(@estimate_item)
    assert_response :success
  end

  test "should update estimate_item" do
    patch estimate_item_url(@estimate_item), params: { estimate_item: { amount: @estimate_item.amount, name: @estimate_item.name, option_group_id: @estimate_item.option_group_id, part_id: @estimate_item.part_id } }
    assert_redirected_to estimate_item_url(@estimate_item)
  end

  test "should destroy estimate_item" do
    assert_difference('EstimateItem.count', -1) do
      delete estimate_item_url(@estimate_item)
    end

    assert_redirected_to estimate_items_url
  end
end
