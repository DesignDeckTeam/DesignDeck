require 'test_helper'

class Account::VersionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get account_versions_show_url
    assert_response :success
  end

end
