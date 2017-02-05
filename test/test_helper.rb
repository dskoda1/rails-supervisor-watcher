ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'webmock/minitest'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login
    @user = users(:user1)
    post user_session_path, params: { 'user[email]' => @user.email, 'user[password]' => 'password' }
  end
  
  def get_supervisor(user, name = 'localhost')
    Supervisor.new(name: name,
                       hostname: name,
                       port: '8082',
                       user: user)
  end
  
  def logout
    delete destroy_user_session_path
  end
  
end
