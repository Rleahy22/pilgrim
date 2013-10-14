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

  var $background = $('.pseudo-box-shadow, .carrot');
  var $border = $('.icon-description');
  var $carrot = $('.carrot');
  var $text = $('.icon-description span');

  $('.globe').on('click', function() {
    $background.animate({backgroundColor: '#96a240'});
    $border.animate({borderColor: '#96a240'})
    $carrot.animate({left: '14%'});
    $text.hide();
    $('#globe').fadeIn();
  });

  $('.translate').on('click', function() {
    $background.animate({backgroundColor: '#5b0000'});
    $border.animate({borderColor: '#5b0000'})
    $carrot.animate({left: '48%'});
    $text.hide();
    $('#translate').fadeIn();
  });

  $('.dbc').on('click', function() {
    $background.animate({backgroundColor: '#b87c47'});
    $border.animate({borderColor: '#b87c47'})
    $carrot.animate({left: '82%'});
    $text.hide();
    $('#dbc').fadeIn();
  });

  var level = 1
  var round = 1

  setInterval(moveSlider, 2000);

  function moveSlider() {
    if (level < 30) {
    level = level + 8;
    } else {
      level = 1;
    };
    if (round === 1) {
      original = 'en';
      different = 'fr';
    };
    if (level === 9) {
      change = true;
      current = $('.one');
      other = $('.uno');
    } else if (level === 17) {
      current = $('.two');
      other = $('.dos');
    } else if (level === 25) {
      current = $('.three');
      other = $('.tres');
    } else if (level === 33) {
      current = $('.four');
      other = $('.cuatro');
    } else {
      change = false;
      current = null;
      other = null;
      original = 'fr';
      different = 'en';
      $('.words').css("font-weight", 200);
      changeWord($('.one'), original, different, change);
      changeWord($('.uno'), original, different, change);
      changeWord($('.two'), original, different, change);
      changeWord($('.dos'), original, different, change);
      changeWord($('.three'), original, different, change);
      changeWord($('.tres'), original, different, change);
      changeWord($('.four'), original, different, change);
      changeWord($('.cuatro'), original, different, change);
    };

    $('.slider').val(level);
    changeWord(current, original, different, change);
    changeWord(other, original, different, change);
    function changeWord(translated, source, target, shouldChange) {
      word = translated.html();
      $.getJSON('https://www.googleapis.com/language/translate/v2?key=AIzaSyALN7om8pcP6n5BhSB0v9K23KQB4B1mefo&q=' + word + '&source=' + source + '&target=' + target, function(data) {
        replacement = data.data["translations"][0]["translatedText"];
        translated.html(replacement);
        if (change === true) {
          translated.css("font-weight", "bold");
        };
      });
    };
  };
});
