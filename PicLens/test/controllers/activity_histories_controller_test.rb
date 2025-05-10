require "test_helper"

class ActivityHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get activity_histories_index_url
    assert_response :success
  end

  test "should get show" do
    get activity_histories_show_url
    assert_response :success
  end

  test "should get new" do
    get activity_histories_new_url
    assert_response :success
  end

  test "should get create" do
    get activity_histories_create_url
    assert_response :success
  end

  test "should get edit" do
    get activity_histories_edit_url
    assert_response :success
  end

  test "should get update" do
    get activity_histories_update_url
    assert_response :success
  end

  test "should get destroy" do
    get activity_histories_destroy_url
    assert_response :success
  end
end
