# encoding: UTF-8
class Translator
  require 'htmlentities'
  require 'open-uri'
  require 'json'
  API_BASE = "https://www.googleapis.com/language/translate/v2?key=" + ENV['GAPI'] + "&q="

  def initialize(query, source_language, target_language)
    @query  = query
    @source_language = source_language
    @target_language = target_language
  end

	def fetch
    words = remove_html
    translation = translate(words)
    verification = verify(translation.flatten)
	  return parser = {
      :source => @query.flatten,
      :target => translation.flatten,
      :verify => verification.flatten
    }
	end

  def translate(text)
    sentences = text.join(' ').split('.')

    sentences.each_slice(5).map do |paragraph|
      escaped = URI.escape(paragraph.join(' '))
      api_request(escaped, @source_language, @target_language)[0]['translatedText'].split(' ')
    end
  end

  def reverse_translation(text) # name?
    text.each_slice(100).map do |tar_arr|
      # check if openuri will handle query params for you so you can avoid the &foo=bar stuff
      tar_words = URI.escape(tar_arr.join('&q='))
      api_request(tar_words, @target_language, @source_language).map!(&:values)
    end
  end

  def remove_html
    @query.reject { |element| element =~ /\<.*\>/ }
  end

  def api_request(query, src, tar)
    puts "Processing a query in #{src} to #{tar}" + query
    # check if openuri will handle query params for you so you can avoid the &foo=bar stuff
    response = open(API_BASE + query + "&source=" + src + "&target=" + tar)
    json = JSON.parse(response.read)
    json['data']['translations']
  end
end

# if $0 == __FILE__
#   src = ["<div>", "<p class=\"fig-chapo\">", "Des", "hackers", "ont", "pénétré", "à", "partir", "de", "serveurs", "basés", "en", "Chine", "plusieurs", "systèmes", "informatiques", "du", "gouvernement", "d'Ottawa,", "obligeant", "celui-ci", "à", "couper", "certains", "de", "ses", "accès", "Internet.", "Pékin", "dément", "toute", "implication.", "</p>", "<div class=\"fig-article-body\">", "<p>", "Ce", "n'est", "pas", "la", "première", "affaire", "du", "genre.", "Le"]
#   translate = Translator.new(src, 'fr', 'en')
#   p translate.api_request
# end
