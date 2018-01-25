class UserController < ApplicationController
  before_filter :authenticate_user!

  def index
    @allArticles = current_user.articles.last(10).reverse
    @prefill = { }
    @prefill['link'] = params['link']
    @prefill['quote'] = params['quote']
    @prefill['title'] = params['title']

    p @prefill
  end

  def export_articles
    @articles = current_user.articles.all.reverse

    # export articles in reverse chronological order
    @articles.sort_by { |a| a.created_at }
    @articles.reverse!

    respond_to do |format|
      format.html do 
        send_data(render_to_string(partial: "user/export_articles", layout: false, articles: @articles), type: 'text/html', filename: "cutout-articles-#{Date.today}.html", disposition: 'attachment')
      end

      format.json do
        articles = JSON.pretty_generate(@articles.as_json(only: [:link, :quote, :author, :tags, :title]))
        send_data(articles, type: 'application/json', filename: "cutout-articles-#{Date.today}.json", disposition: 'attachment')
      end
    end
  end
end
