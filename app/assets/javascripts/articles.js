var articleClasses = "";

var changeArticleSize = function(article) {
  articlePosition = article.position();
  article.after(article.clone())
  article.attr('class', 'active-article')
  $('#' + article.attr('id') + '.article-tile').hide();
  article.css({
    'position': 'absolute',
    'top': articlePosition.top,
    'left': articlePosition.left,
    'backgroundColor': 'white'
  });
  article.animate({
    top: 0,
    left: '20%',
    width: '60%',
    height: 'auto',
  }, function() {
    $('.show-all-articles').fadeIn();
    $(".article-tile").slideUp();
  });
};

var fadeObjects = function(clickedId) {
  $('.article-tile').each(function(i,obj) {
     if ( $(obj).attr('id') != clickedId ) {
       $(obj).fadeTo(i*50, 0.0);
     }
  });
};

var slideInTiles = function() {
  $('.article-tile').each(function(i,obj) {
    $(obj).slideDown();
    $(obj).fadeTo(i * 100, 1.0);
  });
}

var createHandlebars = function(data) {
  template = Handlebars.compile($('#text-template').html());
  articleJson = $('[data-parsed-article]').text();
  translation = {words: JSON.parse(articleJson)};
  window.currentArticle = new Article($("#article"), template, translation);
  window.currentArticle.render();
};

var fixFooter = function() {
  $('body').css('height',$(document).height() + 100);

};

$(document).ready( function() {
  $('body').on('click', '.article-tile', function() {
    var $this = $(this);
    var clickedId = $this.attr('id');
    var totalTime = ( $('.article-tile').length * 50 );
    articleClasses = $this.attr('class');
    fadeObjects(clickedId);

    $.ajax({
      url: '/articles/grab',
      type: 'POST',
      data: {id: clickedId, language: $this.data('language')},
      beforeSend: function() {
        changeArticleSize($this);
      },
      success: function(data) {
        $this.html(data);
        createHandlebars(data);
        $('footer').hide();
      }
    });

  });

  $('#landing').on('mouseenter', '.foreign', function() {
    current = $(this);
    word = current.html();
    source = $('#article').data('source');
    target = $('#slider').data('source');
    $.getJSON('https://www.googleapis.com/language/translate/v2?key=AIzaSyALN7om8pcP6n5BhSB0v9K23KQB4B1mefo&q=' + word + '&source=' + target + '&target=' + source, function(data) {
      replacement = data.data["translations"][0]["translatedText"];
      current.html(replacement);
      current.css("background-color", "#B8B8B8");
    });
    $('#article').on('mouseleave', '.foreign', function() {
      current.css("background-color", "transparent");
      current.html(word);
    });
  });

  $('.show-all-articles').on('click', function() {
    var $viewedArticle = $('.active-article');
    slideInTiles()
    $viewedArticle.remove();
    $(this).fadeOut();
  });

  $('body').on('change', '#slider', function() {
    console.log("Meow.");
    window.currentArticle.updateTranslation($('#slider').val());
  });

  $('body').on('change', '#language', function() {
    $.ajax({
      url: '/articles/grab',
      type: 'POST',
      data: {
        id: $('.active-article').attr('id'),
        language: $('#language').val()
      },
      success: function(data) {
        $('.active-article').html(data);
        createHandlebars(data);
      }
    });
  });

});
