class Article < ActiveRecord::Base
  require 'open-uri'

  attr_accessible :translatable, :content, :image, :title, :url
end
