require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user1)
    
    # Note: I have set index_path to be a page that can only be accessed when logged in
    # Please change the page if need be
    @logged_in_path = index_path
  end

  test "should get redirected when trying to access log in page" do
    get @logged_in_path
    assert_redirected_to new_user_session_path, "User is not redirected!"
  end
  
  test "login with invalid information" do
    
    # Go to Login Page
    get new_user_session_path
    assert_template 'devise/sessions/new'
    
    # Attempt to login with invalid information
    post user_session_path, params: { 'user[email]' => '', 'user[password]' => '' }
    
    # Confirm that current page is the login page
    assert_template 'devise/sessions/new'
    
    # Confirm that there is a flash warning message
    assert_not flash.empty?
  end
  
  test "login with valid information followed by logout" do
    
    get new_user_session_path
    assert_template 'devise/sessions/new'
    
    post user_session_path, params: { 'user[email]' => @user.email, 'user[password]' => 'password' }
    
    get @logged_in_path
    assert_response :success
    
    # Log out after successfully logging in
    delete destroy_user_session_path
    
    get @logged_in_path
    assert_redirected_to new_user_session_path
    
  end
  

end
