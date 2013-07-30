require 'spec_helper'

describe SemanticParser do
  let(:parser) do 
    SemanticParser.new(nil, nil, nil, {
      :source => ["the", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog", "quick"], 
      :target => ["Le", "rapide", "renard", "brun", "saute", "sur", "le", "chien", "paresseux", "rapide"], 
      :verify => ['the', 'Quick', 'fox', 'brown', 'jumps', 'about', 'the', 'dog', 'lazy', 'quick']
    })
  end

  describe "#initialize" do
    it "hits API without a translated source" do
      SemanticParser.any_instance.stub(:translate) { {source: nil, target: nil, verify: nil} }
      SemanticParser.any_instance.should_receive(:translate)
      SemanticParser.new(nil, nil, nil, nil)
    end

    it "avoids translation with a translated source" do
      SemanticParser.any_instance.stub(:translate)
      SemanticParser.any_instance.should_not_receive(:translate)
      SemanticParser.new(nil, nil, nil, {})
    end

    it "passes correct values to the translate function" do
      SemanticParser.any_instance.stub(:translate) { {source: nil, target: nil, verify: nil} }
      SemanticParser.any_instance.should_receive(:translate).with("en", "fr")
      SemanticParser.new(nil, "en", "fr")
    end
  end
  
  describe "#parse" do
    it "returns an array of hashes" do
      expect(parser.parse).to eq parser.json
    end
  end

  describe "#correlate_words" do
    it "can find multiple matches" do
      parser.correlate_words
      expect(parser.correlated_words.values.map(&:length)).to include 2 
    end
  end

  describe "#select_correct_correlation" do
    it "leaves no words with multiple matches" do
      parser.correlate_words
      parser.select_correct_correlation
      expect(parser.correlated_words.values.map(&:class).uniq).to eq [Fixnum]
    end
  end

  describe "#generate_json" do
    it "returns a hash" do 
      parser.parse
      expect(parser.json.class).to  eq Hash
    end

    it "assigns atleast one word to each index" do
      parser.parse
      expect(parser.json.values.map { |word| word["source"].to_s }).not_to include ""
    end
  end

  describe "#assign_proficiency_levels" do
    it "assigns values over 9000!!" do
      expect(parser.parse.values.map { |word| word["level"] }).to include 9001
    end

    it "evenly distributes levels" do
    end
  end
end
