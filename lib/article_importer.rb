class ArticleImporter
  require 'open-uri'

  attr_reader :article_contents, :article_urls

  def initialize(rss_url)
    @rss_url = rss_url
    @article_urls = []
    @article_contents = []
  end

  def fetch_and_import
    fetch_article_urls
    reject_existing_urls
    fetch_json_content
    parse_articles
  end

  def fetch_article_urls
    feed = Feedzirra::Feed.fetch_and_parse(@rss_url)
    @article_urls = feed.entries.map { |entry| entry.url }
  end

  def reject_existing_urls
    article_urls.reject! { |url| Article.find_by_url(url) }
  end

  def fetch_json_content
    @article_contents = @article_urls.first(2).map do |url|
      p url
      url = url.gsub(/#.+/, '')
      sleep 1
      api_format = "https://www.readability.com/api/content/v1/parser?url=#{url}&token=ee8e522664d780a6cd208df1d21fa424f7fe400d"
      JSON.parse(open(api_format).read)
    end
  end

  def parse_articles
    article_contents.map do |article|
      stripped_content = strip_content(article["content"])

      {title: article["title"],
       url: article["url"],
       image: article["lead_image_url"],
       content: article["content"],
       summary: generate_summary(stripped_content),
       translatable: generate_translatable(stripped_content),
       source_language: determine_source(article["title"])}
    end
  end

  def strip_content(content)
    split_html = content.split(/(<\/?[^>]*>)/)
    split_html.map { |el| el.strip }
  end

  def generate_summary(stripped_content)
    summary = stripped_content.reject { |el| el.match(/<\/?[^>]*>/) }
    summary.first(25).join(' ')
  end

  def generate_translatable(stripped_content)
    stripped_content.reject! { |el| el.empty? }
    words_split = stripped_content.map { |phrase| phrase.match(/<\/?[^>]*>/) ? phrase : phrase.split(' ') }
    words_split.flatten!.join("|&")
  end

  def determine_source(title)
    query = URI::encode(title).gsub(' ', "%20")
    request = open('https://www.googleapis.com/language/translate/v2/detect?key=' + ENV['GAPI'] + '&q=' + query)
    google_response = JSON.parse(request.read)
    google_response["data"]["detections"][0][0]["language"]
  end
end
