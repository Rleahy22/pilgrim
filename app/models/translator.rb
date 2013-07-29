require 'open-uri'
require 'json'
require 'htmlentities'
API_BASE = "https://www.googleapis.com/language/translate/v2?key=" + ENV['GAPI'] + "&q="
class Translator
	def self.fetch(query, source, target)
    words       = query.reject { |element| element =~ /\<.*\>/ }
    translation = words.join(' ').split('.').each_slice(15) do |sentences|
      api_request(URI.escape(sentences), source, target)
    end.flatten
    verify      = translation.each_slice(100) do |word|
      tar_word.join('%0A')
    end.flatten
	  return parser = {
      :source => query,
      :target => translation,
      :verify => verify
    }
	end

  def api_request(sentence, source, target)
    api_hit = open(API_BASE + sentence + "&source=" + source + "&target=" + target)
    api_return = JSON.parse(api_hit.read)
    api_return['data']['translations'][0]['translatedText'].split(' ')
  end
end

if $0 == __FILE__
  ["<div>", "<p class=\"fig-chapo\">", "Des", "hackers", "ont", "p&#xE9;n&#xE9;tr&#xE9;", "&#xE0;", "partir", "de", "serveurs", "bas&#xE9;s", "en", "Chine", "plusieurs", "syst&#xE8;mes", "informatiques", "du", "gouvernement", "d'Ottawa,", "obligeant", "celui-ci", "&#xE0;", "couper", "certains", "de", "ses", "acc&#xE8;s", "Internet.", "P&#xE9;kin", "d&#xE9;ment", "toute", "implication.", "</p>", "<div class=\"fig-article-body\">", "<p>", "Ce", "n'est", "pas", "la", "premi&#xE8;re", "affaire", "du", "genre.", "Le", "gouvernement", "canadien", "a", "&#xE9;t&#xE9;", "victime", "en", "janvier", "d'une", "cyberattaque", "majeure", "en", "provenance", "de", "Chine,", "ont", "rapport&#xE9;", "mercredi", "des", "m&#xE9;dias", "locaux.", "Les", "hackers", "ont", "r&#xE9;ussi", "&#xE0;", "prendre", "le", "contr&#xF4;le", "d'ordinateurs", "de", "hauts", "fonctionnaires", "canadiens", "de", "deux", "administrations", "strat&#xE9;giques", ":", "le", "minist&#xE8;re", "des", "Finances", "et", "le", "Conseil", "du", "Tr&#xE9;sor.", "</p>", "<p>", "Le", "but", "de", "ce", "raid", "informatique", "&#xE9;tait", "de", "mettre", "la", "main", "sur", "les", "mots", "de", "passe", "des", "syst&#xE8;mes", "afin", "&#xAB;de", "d&#xE9;bloquer", "toutes", "les", "bases", "de", "donn&#xE9;es", "du", "gouvernement&#xBB;,", "souligne", "la", "t&#xE9;l&#xE9;vision", "publique", "CBC.", "Suite", "&#xE0;", "cette", "intrusion,", "l'acc&#xE8;s", "&#xE0;", "Internet", "a", "&#xE9;t&#xE9;", "coup&#xE9;", "dans", "les", "deux", "minist&#xE8;res", "concern&#xE9;s,", "obligeant", "leurs", "employ&#xE9;s", "&#xE0;", "travailler", "de", "chez", "eux", "ou", "depuis", "des", "cyber-caf&#xE9;s.", "D'autres", "minist&#xE8;res", "auraient", "pu", "&#xEA;tre", "&#xE9;galement", "affect&#xE9;s,", "note", "CBC.", "Le", "Secr&#xE9;tariat", "du", "Conseil", "du", "Tr&#xE9;sor,", "qui", "reconna&#xEE;t", "&#xAB;une", "tentative", "non", "autoris&#xE9;e", "d'acc&#xE9;der", "&#xE0;", "son", "r&#xE9;seau&#xBB;,", "souligne", "qu'&#xAB;il", "n'y", "a", "aucune", "indication", "que", "des", "donn&#xE9;es", "priv&#xE9;es", "de", "Canadiens", "aient", "&#xE9;t&#xE9;", "compromises&#xBB;.", "Les", "services", "secrets", "ont", "n&#xE9;anmoins", "&#xE9;t&#xE9;", "mobilis&#xE9;s", "pour", "s'en", "assurer", "et", "pour", "identifier", "les", "auteurs", "de", "la", "cyberattaque.", "</p>", "<h3>", "Pirates", "ind&#xE9;pendants", "ou", "pilot&#xE9;s", "par", "P&#xE9;kin", "?", "</h3>", "<p>", "Les", "serveurs", "d'o&#xF9;", "est", "partie", "l'attaque", "ont", "&#xE9;t&#xE9;", "localis&#xE9;s", "en", "Chine.", "Mais", "rien", "ne", "prouve", "encore", "qu'ils", "aient", "&#xE9;t&#xE9;", "utilis&#xE9;s", "par", "des", "Chinois.", "Le", "cas", "&#xE9;ch&#xE9;ant,", "s'agit-il", "de", "pirates", "ind&#xE9;pendants", "ou", "bien", "sont-ils", "t&#xE9;l&#xE9;command&#xE9;s", "par", "le", "gouvernement", "de", "P&#xE9;kin", "?", "Impossible", "&#xE0;", "d&#xE9;terminer,", "selon", "le", "gouvernement", "canadien.", "Mais", "pour", "la", "cha&#xEE;ne", "priv&#xE9;e", "CTV,", "la", "seconde", "solution", "ne", "fait", "aucun", "doute,", "m&#xEA;me", "si", "&#xAB;le", "Service", "canadien", "du", "renseignement", "de", "s&#xE9;curit&#xE9;", "a", "conseill&#xE9;", "aux", "responsables", "du", "gouvernement", "de", "ne", "pas", "nommer", "la", "Chine", "comme", "&#xE9;tant", "le", "pays", "d'o&#xF9;", "l'attaque", "a", "&#xE9;t&#xE9;", "lanc&#xE9;e&#xBB;.", "&#xAB;L'espionnage", "en", "provenance", "de", "Chine", "est", "devenu", "un", "probl&#xE8;me", "majeur", "pour", "le", "Canada&#xBB;,", "t&#xE9;moigne", "pour", "la", "cha&#xEE;ne", "un", "fonctionnaire", "&#xAB;haut", "plac&#xE9;&#xBB;,", "sous", "couvert", "de", "l'anonymat.", "</p>", "<p>", "&#xAB;Les", "all&#xE9;gations", "selon", "lesquelles", "le", "gouvernement", "chinois", "soutient", "le", "piratage", "informatique", "sont", "infond&#xE9;es&#xBB;,", "s'est", "d&#xE9;fendu", "jeudi", "P&#xE9;kin.", "&#xAB;Le", "gouvernement", "chinois", "attache", "de", "l'importance", "&#xE0;", "la", "s&#xE9;curit&#xE9;", "des", "r&#xE9;seaux", "informatiques", "et", "demande", "aux", "utilisateurs", "des", "ordinateurs", "et", "de", "l'internet", "de", "se", "conformer", "aux", "lois", "et", "r&#xE8;glements&#xBB;,", "a", "d&#xE9;velopp&#xE9;", "le", "porte-parole", "du", "minist&#xE8;re", "chinois", "des", "Affaires", "&#xE9;trang&#xE8;res,", "ajoutant", "que", "&#xAB;la", "Chine", "est", "aussi", "une", "victime", "du", "piratage&#xBB;.", "</p>", "<p>", "Reste", "que", "ces", "soup&#xE7;ons", "ne", "font", "que", "s'ajouter", "aux", "nombreux", "autres", "pesant", "d&#xE9;j&#xE0;", "sur", "la", "Chine", "&#xE0;", "propos", "du", "piratage", "informatique.", "La", "semaine", "derni&#xE8;re", "encore,", "la", "soci&#xE9;t&#xE9;", "de", "s&#xE9;curit&#xE9;", "informatique", "McAfee", "rapportait", "que", "<a href=\"http://www.lefigaro.fr/hightech/2011/02/10/01007-20110210ARTFIG00526-des-groupes-petroliers-pirates-par-des-hackers-de-chine.php\" target=\"\">", "plusieurs", "grands", "groupes", "p&#xE9;troliers", "internationaux", "sont", "victimes", "</a>", "depuis", "plus", "d'un", "an", "de", "pirates", "informatiques", "chinois", "qui", "cherchent", "&#xE0;", "voler", "des", "informations", "confidentielles.", "Et", "l'an", "dernier,", "une", "commission", "du", "Congr&#xE8;s", "am&#xE9;ricain", "avait", "accus&#xE9;", "P&#xE9;kin", "de", "piloter", "des", "attaques", "&#xAB;massives&#xBB;", "contre", "les", "syst&#xE8;mes", "informatiques", "am&#xE9;ricains.", "En", "janvier", "2010,", "<a href=\"http://www.lefigaro.fr/international/2010/12/05/01003-20101205ARTFIG00244-pekin-implique-dans-le-piratage-de-google.php\" target=\"\">", "c'&#xE9;tait", "Google", "qui", "se", "disait", "victime", "d'attaques", "originaires", "de", "Chine", "</a>", ",", "qui", "visaient", "notamment", "des", "comptes", "Google", "appartenant", "&#xE0;", "des", "militants", "des", "droits", "de", "l'Homme.", "Les", "autorit&#xE9;s", "chinoises", "ont", "toujours", "ni&#xE9;", "toute", "implication.", "</p>", "<p>", "<strong>", "LIRE", "AUSSI", ":", "</strong>", "</p>", "<p>", "<a href=\"http://www.lefigaro.fr/hightech/2011/02/10/01007-20110210ARTFIG00526-des-groupes-petroliers-pirates-par-des-hackers-de-chine.php\" target=\"\">", "&#xBB;", "Des", "groupes", "p&#xE9;troliers", "pirat&#xE9;s", "par", "des", "hackers", "de", "Chine", "</a>", "</p>", "<p>", "<a href=\"http://www.lefigaro.fr/international/2010/12/05/01003-20101205ARTFIG00244-pekin-implique-dans-le-piratage-de-google.php\" target=\"\">", "&#xBB;", "P&#xE9;kin", "impliqu&#xE9;", "dans", "le", "piratage", "de", "Google", "</a>", "</p>", "<p>", "<a href=\"http://www.lefigaro.fr/web/2010/03/30/01022-20100330ARTFIG00692-la-redaction-a-repondu-a-vos-questions-sur-google-en-chine-.php\" target=\"\">", "&#xBB;", "La", "r&#xE9;daction", "a", "r&#xE9;pondu", "&#xE0;", "vos", "questions", "sur", "Google", "en", "Chine", "</a>", "</p>", "<liste>", "<element>", "</element>", "</liste>", "</div>", "</div>"]
end
