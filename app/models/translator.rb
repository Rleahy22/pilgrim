# encoding: UTF-8
require 'htmlentities'
require 'open-uri'
require 'json'
API_BASE = "https://www.googleapis.com/language/translate/v2?key=" + ENV['GAPI'] + "&q="
class Translator
	def self.fetch(query, source, target)
    words       = query.reject { |element| element =~ /\<.*\>/ }
    translation = []
    words.join(' ').split('.').each_slice(3) do |sentences|
      sentence = URI.escape(sentences.join(' '))
      translation << Translator.api_request(sentence, source, target)[0]['translatedText'].split(' ')
    end
    verify      = []
    translation.each_slice(25) do |tar_arr|
      tar_words = URI.escape(tar_arr.join('&q='))
      verify << Translator.api_request(tar_words, target, source).map!(&:values)
    end
	  return parser = {
      :source => query.flatten,
      :target => translation.flatten,
      :verify => verify.flatten
    }
	end

  def self.api_request(sentence, source, target)
    api_hit = open(API_BASE + sentence + "&source=" + source + "&target=" + target)
    api_return = JSON.parse(api_hit.read)
    api_return['data']['translations']
  end
end

if $0 == __FILE__
  src = ["<div>", "<p class=\"fig-chapo\">", "Des", "hackers", "ont", "pénétré", "à", "partir", "de", "serveurs", "basés", "en", "Chine", "plusieurs", "systèmes", "informatiques", "du", "gouvernement", "d'Ottawa,", "obligeant", "celui-ci", "à", "couper", "certains", "de", "ses", "accès", "Internet.", "Pékin", "dément", "toute", "implication.", "</p>", "<div class=\"fig-article-body\">", "<p>", "Ce", "n'est", "pas", "la", "première", "affaire", "du", "genre.", "Le"]
  result = Translator.fetch(src, 'fr', 'en')
  result.keys.each { |k| p result[k] }
end
