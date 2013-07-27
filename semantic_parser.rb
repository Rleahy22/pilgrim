# encoding: UTF-8
require 'open-uri'
require 'json'
API_BASE = "https://www.googleapis.com/language/translate/v2?key=" + ENV['GAPI']

class SemanticParser
  attr_reader :translation, :nodes, :corr
	def initialize paragraph_in, src, tar, translation = nil
		@paragraph_in = paragraph_in
		@translation  = translation ||= Translator.fetch(paragraph_in, src, tar)
		@nodes        = node_translation
  end

  def parse
    correlate_nodes
	end

	def clean correlated
		correlated.compact!
		correlated.map!(&closest_match)
	end

	def closest_match_in
		Proc.new do |rel| 
			rel unless rel.values[0].length > 1
			rel.values[0].min { |a,b| (rel.keys[0] - a).abs <=> (rel.keys[0] - b).abs } 
		end
	end

	private

	def correlate_nodes
    @corr = Hash.new { |h,k| h[k] = []}
		@nodes[:verify].each do |index, verify|
      @nodes[:source].each do |i, src|
        @corr[i] << index if src.downcase == verify.downcase
      end
		end
	end
	
  def node_translation
    nodes = {:source => {}, :target => {}, :verify => {}}
    @translation.keys.each do |key|
       @translation[key].each.with_index do |val, i|
         nodes[key][i] = val
       end
    end
    nodes
  end
end

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

if $0 == __FILE__
	G_INPUT 			= "Ultra High Definition TV technology offers resolution measuring 3840 x 2160 pixels, or 8 megapixels -- four times that of 1080p televisions, which offer 2 megapixels of resolution.Besides far higher resolution, one advantage pointed out by industry pundits is that 4K TV can show passive 3D better than today's 1080p sets."
	G_RESPONSE 	= "La technologie de TV haute définition Ultra offre mesurant 3840 x 2160 pixels, soit 8 mégapixels résolution - quatre fois celle des téléviseurs 1080p, offrant 2 mégapixels de résolution. D'ailleurs beaucoup plus haute résolution, un avantage souligné par les experts de l'industrie est que TV 4K 3D passive peut montrer mieux que jeux 1080p d'aujourd'hui."
	G_VERIFY			= ["the", "technology", "of", "TV", "high", "definition", "ultra", "offers", "measuring", "3840", "x", "2160", "pixels", "or", "8", "megapixel", "resolution", "-", "four", "times", "that", "of", "TVs", "1080p", "offering", "2", "megapixel", "of", "resolution", "Indeed", "a lot", "more", "high", "resolution", "a", "advantage", "out", "by", "the", "experts", "of", "industry", "is", "that", "TV", "4K", "3D", "passive", "can", "show", "more", "that", "games", "1080p", "today"]

	parser = SemanticParser.new(nil, nil, nil, {:source => G_INPUT.split, :target => G_RESPONSE.split, :verify => G_VERIFY})
	#parser.nodes.keys.each { |k| p parser.nodes[k] }
  parser.parse
	#puts parser.results
end
