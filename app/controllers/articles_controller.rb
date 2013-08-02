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
    @articles = @articles[0..10]
  end

  def show
    @article = Article.find(params[:id])
    if session[:id]
      @user = User.find(session[:id])
      @language = @user.languages.split(',').sample
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
      @article = Article.find(params[:id])
      unless params[:language]
        if current_user
          @language = (current_user.languages.split(',') - [@article.source_language]).sample
        else
          @language = (['en', 'fr', 'it', 'de', 'es'] - [@article.source_language]).sample
        end
        @language = "en" if @article.source_language != "en"
      else
        @language = params[:language]
      end

      @json = @article.load_translation(@article.source_language, @language)
      render :partial => 'articles/grab'
    end
  end

end
