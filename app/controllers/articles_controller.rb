require 'htmlentities'

class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    # coder = HTMLEntities.new
    # formatted = coder.decode(@article.translatable)
    # @formatted = formatted.split("|&")
  end

  def show
    @article = Article.find(params[:id])
    coder = HTMLEntities.new
    formatted = coder.decode(@article.translatable)
    @formatted = formatted.split("|&")
    parser = SemanticParser.new(@formatted, 'fr', 'en')
    @parsed_article = parser.parse
  end
end
