require 'test_helper'

class TopControllerTest < ActionDispatch::IntegrationTest
  test "should get jp" do
    get top_jp_url
    assert_response :success
  end

  test "should get en" do
    get top_en_url
    assert_response :success
  end

end
