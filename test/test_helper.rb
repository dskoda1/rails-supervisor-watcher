ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login
    @user = users(:user1)
    post user_session_path, params: { 'user[email]' => @user.email, 'user[password]' => 'password' }
  end
  
  def get_supervisor(user)
    s = supervisors(:localhost)
    s.user = user
    s
  end
  
  def logout
    delete destroy_user_session_path
  end
end
