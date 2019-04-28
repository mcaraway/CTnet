require 'test_helper'

class ProductionLinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @production_line = production_lines(:one)
  end

  test "should get index" do
    get production_lines_url
    assert_response :success
  end

  test "should get new" do
    get new_production_line_url
    assert_response :success
  end

  test "should create production_line" do
    assert_difference('ProductionLine.count') do
      post production_lines_url, params: { production_line: { name: @production_line.name } }
    end

    assert_redirected_to production_line_url(ProductionLine.last)
  end

  test "should show production_line" do
    get production_line_url(@production_line)
    assert_response :success
  end

  test "should get edit" do
    get edit_production_line_url(@production_line)
    assert_response :success
  end

  test "should update production_line" do
    patch production_line_url(@production_line), params: { production_line: { name: @production_line.name } }
    assert_redirected_to production_line_url(@production_line)
  end

  test "should destroy production_line" do
    assert_difference('ProductionLine.count', -1) do
      delete production_line_url(@production_line)
    end

    assert_redirected_to production_lines_url
  end
end
