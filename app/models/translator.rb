# encoding: UTF-8
require 'htmlentities'
require 'open-uri'
require 'json'
API_BASE = "https://www.googleapis.com/language/translate/v2?key=" + ENV['GAPI'] + "&q="
class Translator
  def initialize(query, source, target)
    @query  = query
    @source = source
    @target = target
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
    text.join(' ').split(/[.:]/).each_slice(3).map do |sentences|
      sentence = URI.escape(sentences.join(' '))
      api_request(sentence, @source, @target)[0]['translatedText'].split(' ')
    end
  end

  def verify(text)
    text.each_slice(100).map do |tar_arr|
      tar_words = URI.escape(tar_arr.join('&q='))
      api_request(tar_words, @target, @source).map!(&:values)
    end
  end

  def remove_html
    words = @query.reject { |element| element =~ /\<.*\>/ }
  end

  def api_request(query, src, tar)
    puts "Processing a query in #{src} to #{tar}" + query
    api_hit = open(API_BASE + query + "&source=" + src + "&target=" + tar)
    api_return = JSON.parse(api_hit.read)
    api_return['data']['translations']
  end
end

# if $0 == __FILE__
#   src = ["<div>", "<p class=\"fig-chapo\">", "Des", "hackers", "ont", "pénétré", "à", "partir", "de", "serveurs", "basés", "en", "Chine", "plusieurs", "systèmes", "informatiques", "du", "gouvernement", "d'Ottawa,", "obligeant", "celui-ci", "à", "couper", "certains", "de", "ses", "accès", "Internet.", "Pékin", "dément", "toute", "implication.", "</p>", "<div class=\"fig-article-body\">", "<p>", "Ce", "n'est", "pas", "la", "première", "affaire", "du", "genre.", "Le"]
#   translate = Translator.new(src, 'fr', 'en')
#   p translate.api_request
# end
