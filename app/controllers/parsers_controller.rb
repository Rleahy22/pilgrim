# encoding: UTF-8
class ParsersController < ApplicationController
  def test
		source 		= "Ultra High Definition TV technology offers resolution measuring 3840 x 2160 pixels, or 8 megapixels -- four times that of 1080p televisions, which offer 2 megapixels of resolution.Besides far higher resolution, one advantage pointed out by industry pundits is that 4K TV can show passive 3D better than today's 1080p sets."
		target 		= "La technologie de TV haute définition Ultra offre mesurant 3840 x 2160 pixels, soit 8 mégapixels résolution - quatre fois celle des téléviseurs 1080p, offrant 2 mégapixels de résolution. D'ailleurs beaucoup plus haute résolution, un avantage souligné par les experts de l'industrie est que TV 4K 3D passive peut montrer mieux que jeux 1080p d'aujourd'hui."
		verify 		= ["the", "technology", "of", "TV", "high", "definition", "ultra", "offers", "measuring", "3840", "x", "2160", "pixels", "or", "8", "megapixel", "resolution", "-", "four", "times", "that", "of", "TVs", "1080p", "offering", "2", "megapixel", "of", "resolution", "Indeed", "a lot", "more", "high", "resolution", "a", "advantage", "out", "by", "the", "experts", "of", "industry", "is", "that", "TV", "4K", "3D", "passive", "can", "show", "more", "that", "games", "1080p", "today"]

		parser = SemanticParser.new(nil, nil, nil, {:source => source.split, :target => target.split, :verify => verify})
	  parsed = parser.parse
	  render :json => parsed
  end
end
