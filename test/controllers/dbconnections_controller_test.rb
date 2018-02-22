require 'test_helper'

class DbconnectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dbconnection = dbconnections(:one)
  end

  test "should get index" do
    get dbconnections_url
    assert_response :success
  end

  test "should get new" do
    get new_dbconnection_url
    assert_response :success
  end

  test "should create dbconnection" do
    assert_difference('Dbconnection.count') do
      post dbconnections_url, params: { dbconnection: { adapter: @dbconnection.adapter, database: @dbconnection.database, encoding: @dbconnection.encoding, host: @dbconnection.host, mode: @dbconnection.mode, password: @dbconnection.password, port: @dbconnection.port, username: @dbconnection.username } }
    end

    assert_redirected_to dbconnection_url(Dbconnection.last)
  end

  test "should show dbconnection" do
    get dbconnection_url(@dbconnection)
    assert_response :success
  end

  test "should get edit" do
    get edit_dbconnection_url(@dbconnection)
    assert_response :success
  end

  test "should update dbconnection" do
    patch dbconnection_url(@dbconnection), params: { dbconnection: { adapter: @dbconnection.adapter, database: @dbconnection.database, encoding: @dbconnection.encoding, host: @dbconnection.host, mode: @dbconnection.mode, password: @dbconnection.password, port: @dbconnection.port, username: @dbconnection.username } }
    assert_redirected_to dbconnection_url(@dbconnection)
  end

  test "should destroy dbconnection" do
    assert_difference('Dbconnection.count', -1) do
      delete dbconnection_url(@dbconnection)
    end

    assert_redirected_to dbconnections_url
  end
end
