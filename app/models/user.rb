class User < ActiveRecord::Base
  attr_accessible :uid, :email, :given_name, :family_name, :languages

  has_many :interests
end
