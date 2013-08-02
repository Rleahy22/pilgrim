var articleClasses = "";

var changeArticleSize = function(article) {
  articlePosition = article.position();
  article.after(article.clone())

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
    article.attr('class', 'active-article')
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
  $('.show-all-articles').on('click', function() {
    var $viewedArticle = $('.active-article');
    slideInTiles()
    $viewedArticle.hide();
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
