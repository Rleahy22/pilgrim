require 'htmlentities'

class ArticlesController < ApplicationController
  def index
    @article = Article.first
    coder = HTMLEntities.new
    formatted = coder.decode(@article.translatable)
    @formatted = formatted.split("|&")
  end
end