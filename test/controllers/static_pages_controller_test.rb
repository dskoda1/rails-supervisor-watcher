require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    login
  end
  
  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

end
