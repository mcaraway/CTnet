require 'test_helper'

class ProductionEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @production_event = production_events(:one)
  end

  test "should get index" do
    get production_events_url
    assert_response :success
  end

  test "should get new" do
    get new_production_event_url
    assert_response :success
  end

  test "should create production_event" do
    assert_difference('ProductionEvent.count') do
      post production_events_url, params: { production_event: { duration: @production_event.duration, name: @production_event.name, start: @production_event.start } }
    end

    assert_redirected_to production_event_url(ProductionEvent.last)
  end

  test "should show production_event" do
    get production_event_url(@production_event)
    assert_response :success
  end

  test "should get edit" do
    get edit_production_event_url(@production_event)
    assert_response :success
  end

  test "should update production_event" do
    patch production_event_url(@production_event), params: { production_event: { duration: @production_event.duration, name: @production_event.name, start: @production_event.start } }
    assert_redirected_to production_event_url(@production_event)
  end

  test "should destroy production_event" do
    assert_difference('ProductionEvent.count', -1) do
      delete production_event_url(@production_event)
    end

    assert_redirected_to production_events_url
  end
end
