# encoding: UTF-8
class SemanticParser
  attr_reader :input, :translation, :source, :target, :reverse_translation, :correlated_words, :json
	def initialize input, source_lang, target_lang, translation_from_test = nil
		@input               = input
		@translation         = translation_from_test ||= translate(source_lang, target_lang)
    @source              = translation[:source]
    @target              = translation[:target]
    @reverse_translation = translation[:verify]
    @correlated_words    = Hash.new { |h,k| h[k] = []}
    @json                = {}
  end

  def parse
    correlate_words
    select_correct_correlation
    generate_json
    assign_proficiency_levels
    return json
	end

  def correlate_words
    reverse_translation.each_with_index do |reverse, reverse_index|
      source.each_with_index do |source, source_index|
        @correlated_words[source_index] << reverse_index if source.downcase == reverse.downcase
      end
    end
  end

  def select_correct_correlation
	  correlated_words.each do |source,possible_matches|
	  	@correlated_words[source] = possible_matches.min do |a,b| 
        (source - a).abs <=> (source - b).abs
      end
	  end
  end

  def generate_json
    source.each.with_index do |source, index|
      @json[index] = correlated_words.key?(index) ? dynamic(source, index) : static(source)
    end
  end

  def assign_proficiency_levels
    json.each do |index,options|
      if options.key?("target")
        json[index]["level"] = index % 30
      else
        json[index]["level"] = 9001
      end
    end
  end

  def dynamic source, index
    { "source" => source, "target" => target[index] }
  end

  def static source
    { "source" => source }
  end

  def translate(source_lang, target_lang)
    translator = Translator.new(input, source_lang, target_lang)
    translator.fetch
  end
end


if $0 == __FILE__
 	G_INPUT 			= "Ultra High Definition TV technology offers resolution measuring 3840 x 2160 pixels, or 8 megapixels -- four times that of 1080p televisions, which offer 2 megapixels of resolution.Besides far higher resolution, one advantage pointed out by industry pundits is that 4K TV can show passive 3D better than today's 1080p sets."
 	G_RESPONSE 	= "La technologie de TV haute définition Ultra offre mesurant 3840 x 2160 pixels, soit 8 mégapixels résolution - quatre fois celle des téléviseurs 1080p, offrant 2 mégapixels de résolution. D'ailleurs beaucoup plus haute résolution, un avantage souligné par les experts de l'industrie est que TV 4K 3D passive peut montrer mieux que jeux 1080p d'aujourd'hui."
 	G_VERIFY			= ["the", "technology", "of", "TV", "high", "definition", "ultra", "offers", "measuring", "3840", "x", "2160", "pixels", "or", "8", "megapixel", "resolution", "-", "four", "times", "that", "of", "TVs", "1080p", "offering", "2", "megapixel", "of", "resolution", "Indeed", "a lot", "more", "high", "resolution", "a", "advantage", "out", "by", "the", "experts", "of", "industry", "is", "that", "TV", "4K", "3D", "passive", "can", "show", "more", "that", "games", "1080p", "today"]

 	parser = SemanticParser.new(nil, nil, nil, {:source => G_INPUT.split, :target => G_RESPONSE.split, :verify => G_VERIFY})
  parser.parse.each { |x| puts x.inspect }
  # article = ["<div>", "<p class=\"fig-chapo\">", "Des", "hackers", "ont", "pénétré", "à", "partir", "de", "serveurs", "basés", "en", "Chine", "plusieurs", "systèmes", "informatiques", "du", "gouvernement", "d'Ottawa,", "obligeant", "celui-ci", "à", "couper", "certains", "de", "ses", "accès", "Internet.", "Pékin", "dément", "toute", "implication.", "</p>", "<div class=\"fig-article-body\">", "<p>", "Ce", "n'est", "pas", "la", "première", "affaire", "du", "genre.", "Le"]
  # parser = SemanticParser.new(article, 'fr', 'en')
  # parser.parse.values.each do |v|
  #   if v["lvl"] > 9000
  #     p v["src"]
  #   else
  #     p v["tar"]
  #   end
  # end
end
