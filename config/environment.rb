# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Rails.application.routes.default_url_options[:host] = 'articles-read.herokuapp.com'

ActionMailer::Base.smtp_settings = {
	:user_name => ENV['SENDGRID_USERNAME'],
	:password => ENV['SENDGRID_PASSWORD'],
	:domain => ENV['SENDGRID_DOMAIN'],
	:address => 'smtp.sendgrid.net',
	:port => 587,
	:authentication => :plain,
	:enable_starttls_auto => true
}

