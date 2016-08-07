class ApiHelpersController < ApplicationController

	skip_before_filter :verify_authenticity_token
	def user_create
		respond_to do |format|
			new_user = User.new params.require(:user).permit(:username, :email, :password, :password_confirmation)
			if User.where(:email => new_user.email).count > 0
				format.json { render json: { "error" => "Email ID already taken!" }, status: 400 }
			elsif User.where(:username => new_user.username).count > 0
				format.json { render json: { "error" => "Username already taken!" }, status: 400 }
			elsif new_user.password != new_user.password_confirmation
				format.json { render json: { "error" => "Passwords don't match! Check, and try again." }, status: 400 }
			elsif new_user.save
				format.json { render json: new_user, status: :created }
			else
				format.json { render json: { "error" => "Error while creation!"}, status: 500 }
			end
		end
	end
end
