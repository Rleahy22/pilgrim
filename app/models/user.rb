class User < ActiveRecord::Base
  attr_accessible :uid, :email, :given_name, :family_name
end