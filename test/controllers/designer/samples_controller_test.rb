require 'test_helper'

class Designer::SamplesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get designer_samples_show_url
    assert_response :success
  end

  test "should get index" do
    get designer_samples_index_url
    assert_response :success
  end

end
