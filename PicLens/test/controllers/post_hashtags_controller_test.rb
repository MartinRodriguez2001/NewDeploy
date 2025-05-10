require "test_helper"

class PostHashtagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get post_hashtags_index_url
    assert_response :success
  end

  test "should get show" do
    get post_hashtags_show_url
    assert_response :success
  end

  test "should get new" do
    get post_hashtags_new_url
    assert_response :success
  end

  test "should get create" do
    get post_hashtags_create_url
    assert_response :success
  end

  test "should get edit" do
    get post_hashtags_edit_url
    assert_response :success
  end

  test "should get update" do
    get post_hashtags_update_url
    assert_response :success
  end

  test "should get destroy" do
    get post_hashtags_destroy_url
    assert_response :success
  end
end
