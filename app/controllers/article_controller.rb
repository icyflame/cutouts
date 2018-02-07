class ArticleController < ApplicationController
	before_filter :authenticate_user!

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

		params.keys.each { |key| temp[key] = params[key] if Article.column_names.include?(key) }

		if temp.save!
			redirect_to root_path
		else
			render plain: "Could not save the article!"
		end
	end
	def new
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

  def share
    temp = Article.where(:id => params[:id])
    if temp.count >= 1
      @thisOne = temp[0]
    else
      redirect_to root_path, alert: "That article doesn't exist!"
    end
  end

  def send_share
    @emails = params[:emails]
    render plain: "#{@emails}"
  end
end
