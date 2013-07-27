require 'open-uri'
require 'json'
API_BASE = "https://www.googleapis.com/language/translate/v2?key=" + ENV['GAPI']
class Translator
	def self.fetch(query, source, target)
	#	api_call 		= API_BASE + "&q=" + query + "&source=#{source}&target=#{target}" 
	#	api_hit 		= open(api_call)
	#	api_return 	= JSON.parse(api_hit.read)
	#	api_return['data']['translations'][0]['translatedText']
	#	scentences_in 	= paragraph_in.split('.').strip.map { |scen| URI.escape(scen) }
	#	scentences_back = scentences_in.map { |scen| api_call scen, source, target }
    raise "Tried to hit API" 
	end
end
