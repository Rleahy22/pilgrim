require 'spec_helper'

describe SemanticParser do
  let(:lazy) { "the quick brown fox jumps over the lazy dog" }
  let(:paresseux) do 
    SemanticParser.new(nil, nil, nil, {
      :source => ["the", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog", "quick"], 
      :target => ["Le", "rapide", "renard", "brun", "saute", "sur", "le", "chien", "paresseux", "rapide"], 
      :verify => ['the', 'Quick', 'fox', 'brown', 'jumps', 'about', 'the', 'dog', 'lazy', 'quick']
    })
  end

  describe "#initialize" do
    it "hits API without a translated source" do
      expect { SemanticParser.new(nil, nil, nil, nil) }.to raise_error
    end

    it "avoids translation with a translated source" do
      expect { SemanticParser.new(nil, nil, nil, {})  }.not_to raise_error
    end

    it "creates nodes as a Hash" do
      expect(paresseux.nodes.class).to eq Hash
    end

    it "sets translation to a 3 ket hash" do
      expect(paresseux.translation.keys.length).to eq 3
    end
  end
  
  describe "#parse" do
    it "removes all duplicates" do
      paresseux.parse
      expect(paresseux.corr.values.map(&:class).uniq).to eq [Fixnum]
    end

    it "returns a hash" do
      expect(paresseux.parse.class).to eq Hash 
    end

    it "provides a lvl 1 for all elements" do
    end
  end

  describe "@corr" do
    it "filters the results down to their reverse translation" do
      paresseux.parse
      expect(paresseux.corr.keys.count).to eq 9
    end
  end

  describe "@nodes" do
    it "contains a source, target, and verify key" do
      expect(paresseux.nodes.keys).to eq [:source, :target, :verify]
    end

    it "has hash-class values" do
      expect(paresseux.nodes.values[0].class).to eq Hash
    end
  end

end
