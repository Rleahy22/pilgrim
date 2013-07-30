class UsersController < ApplicationController
	def index

	end

	def create
		callback = request.env["omniauth.auth"]
		# switch to first_or_create (or equivalent)
		# http://guides.rubyonrails.org/3_2_release_notes.html
		@user = User.create(uid:         callback[:uid],
		 										email:       callback[:info][:email],
		  									given_name:  callback[:info][:first_name],
		   									family_name: callback[:info][:last_name])
		redirect_to root_url
	end
end