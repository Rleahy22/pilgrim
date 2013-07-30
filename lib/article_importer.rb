class ArticleImporter
  require 'open-uri'

  def initialize(rss_url)
    @rss_url = rss_url
    @article_urls = []
    @article_contents = []
  end

  def get_recent_article_urls
    feed = Feedzirra::Feed.fetch_and_parse(rss_url)
    @article_urls = feed.entries.map { |entry| entry.url }
  end

  def get_json_content
    @article_contents = @article_urls.map do |url|
      api_format = "https://www.readability.com/api/content/v1/parser?url=#{url}&token=ee8e522664d780a6cd208df1d21fa424f7fe400d"
      JSON.parse(open(api_format).read)
      # maybe sleep for 1 second, or 200ms -- to prevent you from getting banned by readability
      sleep 1
    end
  end

  def parsed_articles
    @article_contents.map do |content|
      stripped = stripped_content(content)

      {:content => content,
       :summary => generate_summary(stripped),
       :translatable => generate_translatable(stripped)}
    end
  end

  def stripped_content(content)
    split_html = content.split(/(<\/?[^>]*>)/)
    split_html.map { |el| el.strip }
  end

  def generate_summary(stripped_content)
    summary = stripped_content.reject { |el| el.match(/<\/?[^>]*>/) }
    summary.join(' ')
  end

  def generate_translatable(stripped_content)
    stripped_content.reject! { |el| stripped.empty? }
    words_split = stripped_content.map { |phrase| phrase.match(/<\/?[^>]*>/) ? phrase : phrase.split(' ') }
    words_split.flatten!.join("|&")
  end
end

end