require 'test_helper'

class RestconnectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restconnection = restconnections(:one)
  end

  test "should get index" do
    get restconnections_url
    assert_response :success
  end

  test "should get new" do
    get new_restconnection_url
    assert_response :success
  end

  test "should create restconnection" do
    assert_difference('Restconnection.count') do
      post restconnections_url, params: { restconnection: { appid: @restconnection.appid, appname: @restconnection.appname, debug: @restconnection.debug, description: @restconnection.description, host: @restconnection.host, password: @restconnection.password, username: @restconnection.username } }
    end

    assert_redirected_to restconnection_url(Restconnection.last)
  end

  test "should show restconnection" do
    get restconnection_url(@restconnection)
    assert_response :success
  end

  test "should get edit" do
    get edit_restconnection_url(@restconnection)
    assert_response :success
  end

  test "should update restconnection" do
    patch restconnection_url(@restconnection), params: { restconnection: { appid: @restconnection.appid, appname: @restconnection.appname, debug: @restconnection.debug, description: @restconnection.description, host: @restconnection.host, password: @restconnection.password, username: @restconnection.username } }
    assert_redirected_to restconnection_url(@restconnection)
  end

  test "should destroy restconnection" do
    assert_difference('Restconnection.count', -1) do
      delete restconnection_url(@restconnection)
    end

    assert_redirected_to restconnections_url
  end
end
