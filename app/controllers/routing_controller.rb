class RoutingController < ApplicationController
	def index
		if user_signed_in?
			redirect_to "/users/"
		else
			redirect_to "/static/index"
		end
	end
end
