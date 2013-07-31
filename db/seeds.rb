# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# full_text = "While the world has become fixated on the NSA's domestic and foreign surveillance activities in the past months, the trial of Private First Class Bradley Manning is coming to a close. Concluding arguments were heard today. The government, as BoingBoing notes, is trying to convict Manning using the Espionage Act, and slap him with the charge of 'aiding the enemy.' Manning has plead guilty to \"lesser\" charges. -p We in technology must pay attention to those willing to leak from the government, given that such information has played a key role in the shaping of public opinion regarding piracy and privacy among other issues. The Snowden effect is material, and critical. -p Firedoglake has done a masterful job of not only reporting on the case, but also live-blogging as much as possible. -p The government alleges that Manning leaked not out of a desire to spread knowledge of government and military misdeed, but instead out of a lust for fame. His pride, it was asserted, was proven because the government produced a picture of a smiling Manning. Hard evidence, certainly. -p At the same time, as Nathan Fuller pointed out, \"Govt repeating over & over Manning was obsessed about his own fame, craved notoriety. At same time arguing further he kept identity hidden.\" If you can untangle the logic behind that argument, you are a better person than I. -p Regarding the Collateral Murder video that showed needless civilian deaths, the government, according to Firedoglake merely stated that the clip contained \"action\" and experiences of service members conducting a wartime mission.\" The government put a price on the \"worth\" of the Afghanistan and Iraq Logs that Wikileaks released to the public at $1.3 million and $1.9 million, respectively. -p The idea of prosecuting Manning for \"aiding the enemy\" is worrisome, as it is an around-the-side charge: Manning provided information to the enemy because he gave it to a journalistic organization that published it, allowing the \"enemy\" to read it; this would make all leakers and whistle blowers potentially legally damnable on the same charge. If we set that precedent, investigative journalism will take a body blow."

# word_array = full_text.split

# word_array.each do |word|
#   Word.create(entry: word)
# end

SOURCES = {
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
