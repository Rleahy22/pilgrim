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
    if session[:id]
      @user = User.find(session[:id])
      @language = @user.languages.sample
    else
      @language = ['en', 'fr', 'it', 'de', 'es'].sample
      until @language != @article.source_language
        @language = ['en', 'fr', 'it', 'de', 'es'].sample
      end
    end
    @parsed_article = @article.load_translation(@article.source_language, @language)
  end
end
