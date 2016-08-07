require 'test_helper'

class ApiHelpersControllerTest < ActionController::TestCase
  test "should get password_compare" do
    get :password_compare
    assert_response :success
  end

end
