class UserController < ApplicationController
  before_filter :authenticate_user!, except: [ :public_page ]

  def index
    @allArticles = current_user.articles.all.limit(10)
    @prefill = params
  end

  def public_page
    user = User.where({ username: params[:username] }).first
    if user == nil
      redirect_to root_path, alert: "Username #{params[:username]} doesn't exist! You can create an account with that username if you would like to!"
      return
    end

    @allArticles = user.articles.where ({ :visibility => Article.visibilities["open"] })
  end

  def export_articles
    @articles = current_user.articles.all

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
