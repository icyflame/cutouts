require 'test_helper'

class StaticControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  test "should get about" do
    get :about
    assert_response 200
  end

  test "should get index and not redirect when not logged in" do
    get :index
    assert_response 200
  end
end
