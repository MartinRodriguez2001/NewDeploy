require "test_helper"

class UserTokensControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_tokens_index_url
    assert_response :success
  end

  test "should get show" do
    get user_tokens_show_url
    assert_response :success
  end

  test "should get new" do
    get user_tokens_new_url
    assert_response :success
  end

  test "should get create" do
    get user_tokens_create_url
    assert_response :success
  end

  test "should get edit" do
    get user_tokens_edit_url
    assert_response :success
  end

  test "should get update" do
    get user_tokens_update_url
    assert_response :success
  end

  test "should get destroy" do
    get user_tokens_destroy_url
    assert_response :success
  end
end
