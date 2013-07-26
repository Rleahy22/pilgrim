class Word < ActiveRecord::Base
  attr_accessible :entry

  # def translate
  #   data = open('https://www.googleapis.com/language/translate/v2?key=AIzaSyALN7om8pcP6n5BhSB0v9K23KQB4B1mefo&q=' + word.entry + '&source=en&target=sp')
  #   puts data
  # end
end
