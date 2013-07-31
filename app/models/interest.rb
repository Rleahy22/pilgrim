class Interest < ActiveRecord::Base
  attr_accessible :name, :user_id

  has_many :users
end
