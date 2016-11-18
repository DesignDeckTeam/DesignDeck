require 'test_helper'

class DesignersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get designers_show_url
    assert_response :success
  end

end
