# encoding: UTF-8
module SemanticParser
	require 'open-uri'
	require 'json'

	API_BASE = "https://www.googleapis.com/language/translate/v2?key=" + ENV['GAPI']

	def translate paragraph_in, source, target, mock
		return mock_translate if mock
		scentences_in 	= paragraph_in.split('.').strip.map { |scen| URI.escape(scen) }
		scentences_back = scentences_in.map { |scen| api_call scen, source, target }
	end

	def api_call query, source, target
		api_call 		= API_BASE + "&q=" + query + "&source=#{source}&target=#{target}"
		api_hit 		= open(api_call)
		api_return 	= JSON.parse(api_hit.read)
		api_return['data']['translations'][0]['translatedText']
	end

	def mock_translate
		input_nodes 		= $G_INPUT.split 							#.map.with_index { |v,i| {i => v} }
		response_nodes 	= $G_RESPONSE.split.map.with_index { |v,i| {i => {:target => v, :verify => $G_VERIFY[i]}} }
		input_nodes.each.with_index do |src, index|
			h = Hash.new { |h,k| h[k] = [] }
			response_nodes.each do |tar|
				h[index] << tar.keys[0] if src == tar.values[0][:verify]
			end
			p h if h.keys.any?
		end
	end
end

if $0 == __FILE__
	include SemanticParser
	$G_INPUT 			= "Ultra High Definition TV technology offers resolution measuring 3840 x 2160 pixels, or 8 megapixels -- four times that of 1080p televisions, which offer 2 megapixels of resolution.Besides far higher resolution, one advantage pointed out by industry pundits is that 4K TV can show passive 3D better than today's 1080p sets."
	$G_RESPONSE 	= "La technologie de TV haute définition Ultra offre mesurant 3840 x 2160 pixels, soit 8 mégapixels résolution - quatre fois celle des téléviseurs 1080p, offrant 2 mégapixels de résolution. D'ailleurs beaucoup plus haute résolution, un avantage souligné par les experts de l'industrie est que TV 4K 3D passive peut montrer mieux que jeux 1080p d'aujourd'hui."
	$G_VERIFY			= ["the", "technology", "of", "TV", "high", "definition", "ultra", "offers", "measuring", "3840", "x", "2160", "pixels", "or", "8", "megapixel", "resolution", "-", "four", "times", "that", "of", "TVs", "1080p", "offering", "2", "megapixel", "of", "resolution", "Indeed", "a lot", "more", "high", "resolution", "a", "advantage", "out", "by", "the", "experts", "of", "industry", "is", "that", "TV", "4K", "3D", "passive", "can", "show", "more", "that", "games", "1080p", "today"]

	translate "I wish I could fly", "en", "fr", true


end