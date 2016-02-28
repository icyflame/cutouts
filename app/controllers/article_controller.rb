class ArticleController < ApplicationController
	def index
	end
	def create
		temp = Article.new
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
