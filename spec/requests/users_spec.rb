require 'spec_helper'


describe 'User' do
	context 'visits index' do
		it "can log in with oauth" do
			visit root_url
			find_link("Sign In With Google").visible?
		end
	end

	context 'views top articles' do
		it "should require a current_user" do
		end
	end
end

