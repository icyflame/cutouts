class SearchController < ApplicationController
  before_filter :authenticate_user!
  layout "search"
  def index
    @articles = current_user.articles
    @article_json = @articles.to_json
    gon.articles = @articles
  end
end
