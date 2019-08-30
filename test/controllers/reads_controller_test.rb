require 'test_helper'

class ReadsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get reads_create_url
    assert_response :success
  end

  test "should get destroy" do
    get reads_destroy_url
    assert_response :success
  end

end
