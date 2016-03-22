class ListArticlesController < ApplicationController
	before_filter :authenticate_user!
  def index
		@allArticles = current_user.articles.reverse
  end
end
