class ArticleController < ApplicationController
  include ArticleHelper
  before_filter :authenticate_user!, :except => [:show]

  def index
    if params[:input].match(/^tag:/i)
      requiredTag = params[:input][4...params[:input].size]
      requiredTag = URI::decode(requiredTag)
      @searchArticles = current_user.articles.searchForTag requiredTag
    else
      @searchArticles = current_user.articles.search params[:input]
    end
  end

  def create
    temp = current_user.articles.create

    get_article_params(params).map { |k, v| temp[k.to_s] = v }

    if !temp.valid?
      redirect_to new_article_path(get_article_params(params))
      return
    end

    if temp.save!
      redirect_to root_path
    else
      render plain: "Could not save the article!"
    end
  end

  def new
    @article = { }
    @populated = (params.keys & allowed_params).count > 0

    if @populated
      @article = current_user.articles.create
      get_article_params(params).map { |k, v| @article[k.to_s] = v }
      @article.valid?
    end
  end

  def destroy
    if Article.find(params[:id]).user_id != current_user.id
      redirect_to root_path, alert: "That's not your article to edit!"
      return
    end

    if Article.find(params[:id]).delete
      redirect_to root_path, notice: "That article was deleted!"
    else
      redirect_to root_path, alert: "That article could not be deleted! Try again later."
    end
  end

  def edit
    if Article.find(params[:id]).user_id != current_user.id
      redirect_to root_path, alert: "That's not your article to edit!"
      return
    end

    @thisOne = Article.find(params[:id])
  end

  def update
    if Article.find(params[:id]).user_id != current_user.id
      redirect_to root_path, alert: "That's not your article to edit!"
      return
    end

    temp = Article.find(params[:id])
    params.keys.each { |key| temp[key] = params[key] if Article.column_names.include?(key) }
    if temp.save!
      redirect_to root_path, notice: "Article updated!"
    else
      redirect_to root_path, alert: "Couldn't update that article, try again later."
    end
  end

  def show
    temp = Article.where(:id => params[:id])
    if temp.count < 1 || !show_allowed(temp[0])
      redirect_to root_path, alert: "That article doesn't exist!"
      return
    end
    @article = temp[0]
  end

  def share
    temp = Article.where(:id => params[:id])
    if temp.count >= 1
      @thisOne = temp[0]
    else
      redirect_to root_path, alert: "That article doesn't exist!"
    end
  end

  def send_share
    temp = Article.where(:id => params[:id])
    if temp.count < 1
      redirect_to root_path, alert: "That article doesn't exist!"
      return
    end
    article = temp[0]

    emails = params[:emails]
    emails = emails.split(",")
    emails = emails.map { |email| email.strip }
    valid_emails = emails.select { |email| is_valid_email(email) }

    # send emails to atmost 5 people at once
    valid_emails = valid_emails.slice(0, 5)

    ArticleSharer.share_article(article, valid_emails, current_user, params[:share_as]).deliver

    redirect_to root_path, notice: "Article shared with #{valid_emails.join ", "}"
  end
end
