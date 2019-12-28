require 'test_helper'

class UserControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  include FactoryBot::Syntax::Methods

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    # user = FactoryBot.create(:user)
    # sign_in user
  end

  test "redirect from index to sign_in from homepage if not signed in" do
    get :index

    assert_response 302
    assert_redirected_to new_user_session_path
  end

  test "don't redirect anywhere from index if user is signed in" do
    sign_in FactoryBot.create(:user)

    get :index

    assert_response 200
  end

  test "public page should be available to the public" do
    get :public_page, params: { username: "carson" }
    assert_response 200
  end

  test "public page should be available to signed in users" do
    user = FactoryBot.create(:user)
    sign_in user
    get :public_page, params: { username: "carson" }
    assert_response 200
  end

  test "export_articles shouldn't work if user isn't logged in" do
    get :export_articles

    assert_response 302
    assert_redirected_to new_user_session_path
  end

  test "export_articles works if user is logged in" do
    sign_in FactoryBot.create(:user)

    get :export_articles

    assert_response 200
  end
end
