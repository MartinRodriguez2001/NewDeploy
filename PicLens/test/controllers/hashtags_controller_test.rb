require "test_helper"

class HashtagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hashtags_index_url
    assert_response :success
  end

  test "should get show" do
    get hashtags_show_url
    assert_response :success
  end

  test "should get new" do
    get hashtags_new_url
    assert_response :success
  end

  test "should get create" do
    get hashtags_create_url
    assert_response :success
  end

  test "should get edit" do
    get hashtags_edit_url
    assert_response :success
  end

  test "should get update" do
    get hashtags_update_url
    assert_response :success
  end

  test "should get destroy" do
    get hashtags_destroy_url
    assert_response :success
  end
end
