SOURCES = {
  english: {technology: "http://feeds.feedburner.com/TechCrunch/",
            politics: "http://rss.cnn.com/rss/cnn_allpolitics.rss",
            sports: "http://sports.espn.go.com/espn/rss/news",
            business: "http://rss.cnn.com/rss/money_latest.rss",
            culture: "http://www.huffingtonpost.com/feeds/verticals/arts/index.xml"},
  spanish: {technology: "http://eleconomista.com.mx/tecnociencia/rss",
            politics: "http://eleconomista.com.mx/politica/rss",
            sports: "http://ep00.epimg.net/rss/deportes/portada.xml",
            business: "http://eleconomista.com.mx/empresas/rss",
            culture: "http://ep00.epimg.net/rss/cultura/portada.xml"},
  french: {technology: "http://www.lefigaro.fr/rss/figaro_web.xml",
            politics: "http://www.lefigaro.fr/rss/figaro_politique.xml",
            sports: "http://www.lefigaro.fr/rss/figaro_sport.xml",
            business: "http://www.lefigaro.fr/rss/figaro_actualite-france.xml",
            culture: "http://www.lefigaro.fr/rss/figaro_medias.xml"},
  german: {technology: 'http://www.spiegel.de/wissenschaft/technik/index.rss',
            politics: 'http://www.spiegel.de/politik/index.rss',
            sports: 'http://www.spiegel.de/sport/index.rss',
            business: 'http://www.spiegel.de/wirtschaft/index.rss',
            culture: "http://www.spiegel.de/kultur/index.rss"},
  italian: {technology: "http://lastampa.feedsportal.com/c/32418/f/637788/index.rss",
            politics: "http://lastampa.feedsportal.com/c/32418/f/625688/index.rss?type=100",
            sports: "http://lastampa.feedsportal.com/c/32418/f/625718/index.rss?type=100",
            business: "http://lastampa.feedsportal.com/c/32418/f/625694/index.rss?type=100",
            culture: "http://lastampa.feedsportal.com/c/32418/f/625723/index.rss?type=100"}}

SOURCES.each do |key, value|
  SOURCES[key].each do |k, v|
    articles = ArticleImporter.new(SOURCES[key][k])
    articles.fetch_and_import.each do |article|
      puts "creating article"
      Article.create(article)
    end
  end
end
