class UserController < ApplicationController
  def index
		if not user_signed_in?
			redirect_to root_path, alert: "You need to be logged in to use that feature"
		end

		@allArticles = current_user.articles.last(10).reverse
  end
end
