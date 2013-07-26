require 'rspec'
require_relative 'semantic_parser'

describe SemanticParser do
  let(:lazy) { "the quick brown fox jumps over the lazy dog" }
  let(:paresseux) do 
    SemanticParser.new(nil, nil, nil, {
      :source => ["the", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog"], 
      :target => ["Le", "rapide", "renard", "brun", "saute", "sur", "le", "chien", "paresseux"], 
      :verify => ['the', 'Quick', 'fox', 'brown', 'jumps', 'about', 'the', 'dog', 'lazy']
    })
  end

  describe "#initialize" do

    it "hits API without a translated source" do
      expect { SemanticParser.new(nil, nil, nil, nil) }.to raise_error
    end

    it "avoids translation with a translated source" do
      expect { SemanticParser.new(nil, nil, nil, {})  }.not_to raise_error
    end

    it "creates nodes" do
      expect(paresseux.nodes).not_to eq nil 
    end

  end

end
