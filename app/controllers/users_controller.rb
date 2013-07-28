class UsersController < ApplicationController
	def index

	end

	def login
		callback = request.env["omniauth.auth"]
		@user = User.create(uid:         callback[:uid],
		 										email:       callback[:info][:email],
		  									given_name:  callback[:info][:first_name],
		   									family_name: callback[:info][:last_name])
		redirect_to root_url
	end
end