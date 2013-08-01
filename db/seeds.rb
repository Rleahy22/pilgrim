SOURCES = {
  english: {technology: "http://feeds.feedburner.com/TechCrunch/",
            politics: "http://rss.cnn.com/rss/cnn_allpolitics.rss",
            sports: "http://sports.espn.go.com/espn/rss/news"},
  spanish: {technology: "http://eleconomista.com.mx/tecnociencia/rss",
            politics: "http://eleconomista.com.mx/politica/rss",
            sports: "http://www.economista.com.mx/deportes/rss/"},
  french: {technology: "http://www.lefigaro.fr/rss/figaro_web.xml",
            politics: "http://www.lefigaro.fr/rss/figaro_politique.xml",
            sports: "http://www.lefigaro.fr/rss/figaro_sport.xml"},
  german: {technology: 'http://www.spiegel.de/wissenschaft/technik/index.rss',
            politics: 'http://www.spiegel.de/politik/index.rss',
            sports: 'http://www.spiegel.de/sport/index.rss'},
  italian: {technology: "http://lastampa.feedsportal.com/c/32418/f/637788/index.rss",
            politics: "http://lastampa.feedsportal.com/c/32418/f/625688/index.rss?type=100",
            sports: "http://lastampa.feedsportal.com/c/32418/f/625718/index.rss?type=100"}}

SOURCES.each do |key, value|
  SOURCES[key].each do |k, v|
    articles = ArticleImporter.new(SOURCES[key][k])
    articles.fetch_and_import.each do |article|
      puts "creating article"
      Article.create(article)
    end
  end
end
