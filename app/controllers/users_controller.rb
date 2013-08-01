class UsersController < ApplicationController

	def index

	end

	def login
		callback = request.env["omniauth.auth"]
		@user = User.create(uid:         callback[:uid],
		 										email:       callback[:info][:email],
		  									given_name:  callback[:info][:first_name],
		   									family_name: callback[:info][:last_name])
		session[:user_id] = @user.id
		redirect_to user_path(@user)
	end

	def show
		@user = current_user
	end

	def update
		languages = ''
		params.each { |key,value| languages << key + ',' if value == "1" }
		user = current_user
		user.update_attributes(languages: languages[0..-2])

		if params["interests"]
			params["interests"].each do |interest|
				category = user.interests.where(:name => interest[0]).first_or_initialize
				category.id ? category.destroy : category.save
			end
		end
		redirect_to user_path
	end
end