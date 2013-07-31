class Translation < ActiveRecord::Base
  attr_accessible :json, :language, :article
  serialize :json, Hash
  belongs_to :article
end
