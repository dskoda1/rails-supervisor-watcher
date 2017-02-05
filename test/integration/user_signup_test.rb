require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post user_registration_path, params: { "user[email]" => "", "user[password]" => "foo", "user[password_confirmation]" => "bar" }
    end
    assert_template 'devise/registrations/new'
    assert_select 'div#error_explanation'
  end
  
  test "valid signup information" do
    get new_user_registration_path
    assert_difference 'User.count', 1 do
      post user_registration_path, params: { "user[email]" => "user@example.com", "user[password]" => "password", "user[password_confirmation]" => "password" }
    end
    assert_redirected_to index_path
  end

end
