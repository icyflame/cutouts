class StaticController < ApplicationController
  def index
		if user_signed_in?
			redirect_to "/users/"
		end
  end

  def about
  end
end
