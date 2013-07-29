module ApplicationHelper

  def get_recent_articles(rss_url)
    feed = Feedzirra::Feed.fetch_and_parse(rss_url)
    feed.entries.map { |entry| entry.url }
  end

  def get_content(article)
    api_format = articles.map "https://www.readability.com/api/content/v1/parser?url=#{article}&token=ee8e522664d780a6cd208df1d21fa424f7fe400d"
    JSON.parse(open(api_format).read)
  end

  def parse_json(json_objects)
    json_objects.each do |obj|
      split_html = obj["content"].split(/(<\/?[^>]*>)/)
      stripped = split_html.map { |x| x.strip }
      stripped.reject! { |c| stripped.empty? }
      words_split = stripped.map { |phrase| phrase.match(/<\/?[^>]*>/) ? phrase : phrase.split(' ') }
      @translatable << words_split.flatten!
    end
    @translatable
  end

end
