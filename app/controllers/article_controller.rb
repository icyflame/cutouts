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

		if temp.save!
			redirect_to root_path
		else
			render plain: "Could not save the article!"
		end
	end
	def new
	end
end
