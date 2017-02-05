require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    login
  end
 
  test "logged out should redirect" do
    logout
    get static_pages_home_url
    assert_redirected_to :new_user_session
  end
  
  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

end
