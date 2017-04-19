require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get accounts_index_url
    assert_response :success
  end

  test "should get provider" do
    get accounts_provider_url
    assert_response :success
  end

  test "should get connections" do
    get accounts_connections_url
    assert_response :success
  end

end
