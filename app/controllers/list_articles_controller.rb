class ListArticlesController < ApplicationController
	before_filter :authenticate_user!
  def index
		@allArticles = current_user.articles
  end
end
