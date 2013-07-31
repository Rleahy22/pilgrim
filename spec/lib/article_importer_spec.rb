require 'spec_helper'

describe ArticleImporter do

  let(:french) { ArticleImporter.new("http://www.lefigaro.fr/rss/figaro_web.xml")}

  describe "#initialize" do
    it "requires an rss url" do
      expect { ArticleImporter.new }.to raise_error
    end
  end

  describe '#fetch_and_import' do
    before do
      french.stub(:fetch_article_urls)
      french.stub(:reject_existing_urls)
      french.stub(:fetch_json_content)
      french.stub(:parse_articles)
    end
    it "calls fetches article urls" do
      french.should receive(:fetch_article_urls)
      french.fetch_and_import
    end
    it "calls reject article urls" do
      french.should receive(:reject_existing_urls)
      french.fetch_and_import
    end
    it "calls fetches json content" do
      french.should receive(:fetch_json_content)
      french.fetch_and_import
    end
    it "calls parse_articles" do
      french.should receive(:parse_articles)
      french.fetch_and_import
    end
  end

  describe '#fetch_article_urls' do
    it "creates an article urls array" do
      entry1 = double(:entry, :url => "url1")
      entry2 = double(:entry, :url => "url2")
      rss_response = double(:response, :entries => [entry1, entry2])
      Feedzirra::Feed.stub(:fetch_and_parse).and_return(rss_response)
      french.fetch_article_urls
      french.article_urls.should == ["url1", "url2"]
    end
  end

  describe '#reject_existing_urls' do
    it 'removes urls that exist in the database' do
      Article.create(:url => "url2")

      french.stub(:article_urls).and_return(["url1", "url2"])
      french.reject_existing_urls
      french.article_urls == ["url1"]
    end
  end

  describe '#parse_articles' do
    it 'returns a hash of article contents' do
      french.should receive(:strip_content)
      french.stub(:article_contents).and_return([{"title" => "Test title", "url" => "google.com", "lead_image_url" => "image", "content" => "content"}])
      french.stub(:strip_content).and_return("content2")
      french.stub(:generate_summary).and_return("content2")
      french.stub(:generate_translatable).and_return("content2")
      french.parse_articles
      french.article_contents == {title: "Test title",
                                  url: "google.com",
                                  image: "image",
                                  content: "content",
                                  summary: "content2",
                                  translatable: "content2"}
    end
  end
end