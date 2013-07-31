class ArticlesController < ApplicationController
  require 'htmlentities'
  def index
    @articles = Article.all
    # coder = HTMLEntities.new
    # formatted = coder.decode(@article.translatable)
    # @formatted = formatted.split("|&")
  end

  def show
    @article = Article.find(params[:id])
    @parsed_article = @article.load_translation("fr", "en")
  end
end
