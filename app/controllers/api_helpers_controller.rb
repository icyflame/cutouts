class ApiHelpersController < ApplicationController

	# Function to compare an AES encrypted password
	# with pre-shared key, to the Devise stored password
	# in the Database.
	#
	# Decrypt key, compare using Devise
	# POST params: email, encrypted_password
	# Go code for encryption: https://play.golang.org/p/F-Up3zZS2R
	skip_before_filter :verify_authenticity_token
	def password_compare

		key64 = "MTZvcjMybGVuZ3Roc3RyaW5naGVyZTAxMjM0NTY3ODk="
		iv64 = "AAAAAAAAAAAAAAAAAAAAAA=="
		encrypted_data = "mHKPcyl7Wc1EBL91WQa16v0/QG03m3CxhGmV/mthCsQ="
		encrypted_data = Base64.decode64(encrypted_data.to_s.strip)
		aes = OpenSSL::Cipher::Cipher.new("AES-256-CBC")
		aes.decrypt
		aes.padding = 0
		aes.key = "16or32lengthstringhere0123456789"
		plain = aes.update(encrypted_data) + aes.final

		puts plain

		puts "Password is valid? #{User.where({:email => params[:email]}).first.valid_password?(plaintext_password)}"
	end


end
