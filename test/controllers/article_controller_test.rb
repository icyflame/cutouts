require 'test_helper'

class ArticleControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  include FactoryBot::Syntax::Methods

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryBot.create(:user)
    sign_in user
  end
end
