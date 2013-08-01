class ArticlesController < ApplicationController
  require 'htmlentities'
  def index
    @articles = Article.all
    if current_user && current_user.languages
      @articles = []
      @languages = current_user.languages.split(',')
      @languages.each do |lang|
        @articles << Article.find_all_by_source_language(lang)
      end
      @articles.flatten!
    end
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

  def grab
    if request.xhr?
      p params.inspect
      @article = Article.find(params[:id])
      render :partial => 'articles/grab', :article => @parsed_article
    end
  end

end
