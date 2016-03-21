class ArticleController < ApplicationController
	def index
	end
	def create
		if not user_signed_in?
			redirect_to root_path, alert: "You have to be signed in to use this feature!"
			return
		end
		temp = current_user.articles.create
		temp.link = params[:link]
		temp.quote = params[:quote]
		temp.author = params[:author]

		if temp.save!
			redirect_to root_path
		else
			render plain: "Could not save the article!"
		end
	end
	def new
	end

	def destroy
		if Article.find(params[:id]).delete
			redirect_to root_path, notice: "That article was deleted!"
		else
			redirect_to root_path, alert: "That article could not be deleted! Try again later."
		end
	end
end
