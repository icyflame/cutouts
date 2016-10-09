class UserController < ApplicationController
	before_filter :authenticate_user!

  def index
		@allArticles = current_user.articles.last(10).reverse
  end

  def export_articles
    respond_to do |format|
      format.json do
        articles = JSON.pretty_generate(current_user.articles.all.as_json(only: [:link, :quote, :author]))
        send_data(articles, type: 'application/json', filename: "cutout-articles-#{Date.today}.json", disposition: 'attachment')
      end
    end
  end
end
