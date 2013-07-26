$(document).ready(function(){
  $('.class1').on('click', function(){
    var current = this;
    var word = ($(current).html());
    $.getJSON('https://www.googleapis.com/language/translate/v2?key=AIzaSyALN7om8pcP6n5BhSB0v9K23KQB4B1mefo&q=' + word + '&source=en&target=es', function(data) {
      var replacement = (data.data["translations"][0]["translatedText"]);
      console.log(current);
      console.log(replacement);
      $(current).html(replacement);
    });
  });
});
