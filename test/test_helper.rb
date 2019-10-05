ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/reporters"

Minitest::Reporters.use!



class ActiveSupport::TestCase
	
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper

	

  # Add more helper methods to be used by all tests here...
end


class ActionDispatch::IntegrationTest

	# Log is as a praticular user. 
	def log_in_as(user, password: 'password', remember_me: '1')
		post user_session_path, params: { user: { email: user.email, 
																					password: password,
																					remember_me: remember_me		} }
																		
	end
end 
