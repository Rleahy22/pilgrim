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

	def update
		languages = ''
		params.each { |key,value| languages << key + ',' if value == "1" }
		user = User.find(1)
		user.update_attributes(languages: languages[0..-2])

		params["interests"].each do |interest|
			category = user.interests.where(:name => interest[0]).first_or_initialize
			category.id ? category.destroy : category.save
		end
		redirect_to user_path
	end
end