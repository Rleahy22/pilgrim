require 'open-uri'

class Article < ActiveRecord::Base
  attr_accessible :translatable, :content, :image, :title, :url

  before_save :parse

  def self.get_recent_article_urls(rss_url)
    feed = Feedzirra::Feed.fetch_and_parse(rss_url)
    feed.entries.map { |entry| entry.url }
  end

  def self.get_json_content(urls)
    json_articles = []
    urls.each do |url|
      api_format = "https://www.readability.com/api/content/v1/parser?url=#{url}&token=ee8e522664d780a6cd208df1d21fa424f7fe400d"
      json_articles << JSON.parse(open(api_format).read)
    end
    json_articles
  end

  private

  # moderately janky code below

  def parse
    split_html = self.content.split(/(<\/?[^>]*>)/)
    stripped = split_html.map { |el| el.strip }
    summary = stripped.reject { |el| el.match(/<\/?[^>]*>/) }
    stripped.reject! { |el| stripped.empty? }
    words_split = stripped.map { |phrase| phrase.match(/<\/?[^>]*>/) ? phrase : phrase.split(' ') }
    words_split.flatten!
    article = words_split.join("|&")
    self.translatable = article
    self.summary = summary.join(' ')
  end
end
