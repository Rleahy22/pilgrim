# encoding: UTF-8

class SemanticParser
  attr_reader :translation, :nodes, :corr
	def initialize paragraph_in, src, tar, translation = nil
		@paragraph_in = paragraph_in
		@translation  = translation ||= Translator.fetch(paragraph_in, src, tar)
		@nodes        = node_translation
    @corr = Hash.new { |h,k| h[k] = []}
  end

  def parse
    correlate_nodes
    singlize
    generate
    @translation[:json]
	end

  def generate
    randomize
    @translation[:json] = {} 
    @translation[:source].each.with_index do |src, index|
      @translation[:json][index] = @corr.key?(index) ? levels(@corr[index], src) : levels(src)
    end
  end

	private

  def randomize
    @order = {}
    @corr.values.shuffle.each.with_index { |tar_i, index| @order[tar_i] = (index % 10)+1 }
  end

  def levels tar_i, src = nil
    return { "lvl" => 9001, "src" => tar_i } unless src
    {
      "lvl" => @order[tar_i],
      "src" => src,
      "tar" => @translation[:target][tar_i]
    }
  end

	def correlate_nodes
		@nodes[:verify].each do |index, verify|
      @nodes[:source].each do |i, src|
        @corr[i] << index if src.downcase == verify.downcase
      end
		end
	end
	
	def singlize
	  @corr.each do |k,h| 
	  	@corr[k] = h.min { |a,b| (k - a).abs <=> (k - b).abs } 
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


# if $0 == __FILE__
# 	G_INPUT 			= "Ultra High Definition TV technology offers resolution measuring 3840 x 2160 pixels, or 8 megapixels -- four times that of 1080p televisions, which offer 2 megapixels of resolution.Besides far higher resolution, one advantage pointed out by industry pundits is that 4K TV can show passive 3D better than today's 1080p sets."
# 	G_RESPONSE 	= "La technologie de TV haute définition Ultra offre mesurant 3840 x 2160 pixels, soit 8 mégapixels résolution - quatre fois celle des téléviseurs 1080p, offrant 2 mégapixels de résolution. D'ailleurs beaucoup plus haute résolution, un avantage souligné par les experts de l'industrie est que TV 4K 3D passive peut montrer mieux que jeux 1080p d'aujourd'hui."
# 	G_VERIFY			= ["the", "technology", "of", "TV", "high", "definition", "ultra", "offers", "measuring", "3840", "x", "2160", "pixels", "or", "8", "megapixel", "resolution", "-", "four", "times", "that", "of", "TVs", "1080p", "offering", "2", "megapixel", "of", "resolution", "Indeed", "a lot", "more", "high", "resolution", "a", "advantage", "out", "by", "the", "experts", "of", "industry", "is", "that", "TV", "4K", "3D", "passive", "can", "show", "more", "that", "games", "1080p", "today"]

# 	parser = SemanticParser.new(nil, nil, nil, {:source => G_INPUT.split, :target => G_RESPONSE.split, :verify => G_VERIFY})
#   parser.parse
# end
