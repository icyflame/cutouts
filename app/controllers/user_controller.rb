class UserController < ApplicationController
	before_filter :authenticate_user!
  def index
			@allArticles = current_user.articles.last(10).reverse
  end
end
