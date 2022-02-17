require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get teste" do
    get home_teste_url
    assert_response :success
  end

end
