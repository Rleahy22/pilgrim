class Article < ActiveRecord::Base
  require 'open-uri'
  CODER = HTMLEntities.new
  attr_accessible :translatable, :content, :image, :title, :url, :summary
  has_many :translations

  def load_translation source_language, target_language
    translated_article = self.translations.where(:language => target_language).first_or_initialize
    if translated_article.id
      translated_article.json
    else
      translated_article.update_attributes(:article  => self,
                                           :json     => self.prepare_content(source_language, target_language))
      translated_article.json
    end
  end

  def prepare_content source_language, target_language
    formatted = CODER.decode(self.translatable).split("|&")
    parser = SemanticParser.new(formatted, source_language, target_language)
    parser.parse
  end
end
