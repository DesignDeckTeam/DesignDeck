require 'test_helper'

class Account::SamplesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get account_samples_show_url
    assert_response :success
  end

  test "should get edit" do
    get account_samples_edit_url
    assert_response :success
  end

end
