module SemanticParser
	require 'open-uri'
	require 'json'

	API_BASE = "https://www.googleapis.com/language/translate/v2?key=" + ENV['GAPI']

	def api_call query, source, target
		api_call = API_BASE + "&q=" + query + "&source=#{source}&target=#{target}"
		api_hit = open(api_call)
		JSON.parse(api_hit.read)
	end



end

if $0 == __FILE__
	include SemanticParser



	puts api_call "words", "en", "fr"

	sampleInput 		= Content.new(:value => "")
	sampleResponse 	= Content.new(:value => "")

end