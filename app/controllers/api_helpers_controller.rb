class ApiHelpersController < ApplicationController
  include ApiHelpersHelper
  before_action :authenticate
  skip_before_action :authenticate, :only => [ :user_signin ]

	skip_before_action :verify_authenticity_token
  respond_to :json

	# Signing in a user
	# params must include
	# auth_data (== email || == username), auth_password ( == user.password)
	def user_signin
		if not params.keys.include? "auth_data" or not params.keys.include? "auth_password"
			respond_to do |format|
				format.json { render json: err_resp(msg: "Invalid parameters"), status: 400 }
			end
      return
		end

    # figure out if a user exists
    # Login with Username and Email both are supported
    if User.where(:email => params[:auth_data]).count > 0
      this_user = User.where(:email => params[:auth_data]).first
    elsif User.where(:username => params[:auth_data]).count > 0
      this_user = User.where(:username => params[:auth_data]).first
    else
      respond_to do |format|
        format.json { render json: err_resp(msg:"User not found"), status: 400 }
      end
      return
    end

    if this_user.valid_password?(params[:auth_password])
      # create the session for the user
      this_session = Session.new
      this_session.user_id = this_user.id
      this_session.sid = OpenSSL::Digest::SHA256.new((Time.now.to_i + Random.new(Time.now.to_i).rand(1e3)).to_s).hexdigest
      if this_session.save!
        respond_to do |format|
          format.json { render json: ok_resp(payload: { "session" => this_session, "user" => this_user }), status: 200 }
        end
        return
      else
        respond_to do |format|
          format.json { render json: err_resp(msg:"Could not save session"), status: 500 }
        end
        return
      end
    else
      respond_to do |format|
        # bad password
        format.json { render json: err_resp(msg:"Bad password"), status: 401 }
      end
      return
      return
    end
  end

  # Creating an article from the parameters
	# params must include
	# sid, link (URL to the article), authors, quote
	def article_create
		puts "Paramas doesn't have SID: #{params_doesnt_have_sid params}"
		respond_to do |format|
			if params_doesnt_have_sid params
				format.json { render json: err_resp(msg: "You must provide a session ID!"), status: 401 }
			else
				user_id = get_user_id params[:sid]
				if user_id
					new_article = User.find(user_id).articles.new
					new_article.link = params[:link]
					new_article.quote = params[:quote]
					new_article.author = params[:authors]
					if new_article.save!
						format.json {render json: { "msg" => "Article created!", "res" => new_article }, status: 201 }
					else
						format.json { render json: { "error" => "Server error! Try again in some time." }, status: 500 }
					end
				else
					format.json { render json: { "error" => "Session timed out!" }, status: 401 }
				end
			end
		end
	end

	# List all the articles for the signed in user
	# Params must include
	# sid
	def articles_list
    render json: ok_resp(payload: { "articles": @user.articles }), status: 200
	end

	private
  attr_accessor :user

	def get_user_id(sid)
		this_session = Session.where("created_at > ?", 10.minutes.ago).where(:sid => sid)
		if this_session.count > 0
			this_session.first.user_id
		else
			nil
		end
	end

	def params_doesnt_have_sid(params)
		not params.keys.include? "sid"
	end

  def authenticate
    token = request.headers.fetch("Authorization", "")

    if token == ""
      render json: err_resp(msg: "Token required"), status: 401
      return
    end

    token_pattern = /^Bearer /

    if !token_pattern.match?(token)
      render json: err_resp(msg: "Malformed header"), status: 401
      return
    end

    token.gsub! token_pattern, ""
    token = token.split(" ").first
    session = Session.where(:sid => token).order(created_at: :desc).first
    if session == nil
      render json: err_resp(msg: "Invalid token"), status: 401
      return
    end

    user = User.find(session.user_id)
    if user == nil
      render json: err_resp(msg: "Token not connected to user"), status: 401
      return
    end

    @user = user
  end
end
