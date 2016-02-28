class UserController < ApplicationController
  def index
		@allArticles = Article.all
  end
end
