require 'simplecov'
SimpleCov.start "rails"

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
      username { Faker::Lorem.words(3).join "_" }
      password "password"
      password_confirmation "password"
      confirmed_at Date.today
    end
  end

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
