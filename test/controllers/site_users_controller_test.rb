require 'test_helper'

class SiteUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get site_users_index_url
    assert_response :success
  end

  test "should get show" do
    get site_users_show_url
    assert_response :success
  end

  test "should get new" do
    get site_users_new_url
    assert_response :success
  end

  test "should get edit" do
    get site_users_edit_url
    assert_response :success
  end

  test "should get delete" do
    get site_users_delete_url
    assert_response :success
  end

end
