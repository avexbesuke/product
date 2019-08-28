require 'test_helper'

class EmotionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get emotions_create_url
    assert_response :success
  end

end
