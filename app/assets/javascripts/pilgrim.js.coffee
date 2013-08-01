$ ->
  template = Handlebars.compile($('#text-template').html())
  articleJson = $('[data-parsed-article]').text()
  translation = {words: JSON.parse(articleJson)}

  window.article = new Article($("#article"), template, translation)

  Handlebars.registerHelper "showSourceLanguage", (level, options) ->
    if level >= window.article.proficiency
      return options.fn(this)
    return options.inverse(this)

  $('#slider').slider
    value:1
    min:1
    max:90
    step:1
    slide: (event, ui) ->
      window.article.updateTranslation(ui.value)

  $('#article').on 'mouseenter', '.foreign', ->
    current = $(this)
    word = current.html()
    source = $('#article').data('source')
    $.getJSON 'https://www.googleapis.com/language/translate/v2?key=AIzaSyALN7om8pcP6n5BhSB0v9K23KQB4B1mefo&q=' + word + '&source=en&target=' + source, (data) ->
      replacement = data.data["translations"][0]["translatedText"]
      current.html replacement
      current.effect "highlight", {color:"#B8B8B8"}, 700
    $('#article').on 'mouseleave', '.foreign', ->
      current.html word

  window.article.render()

window.Article = class Article
  constructor: (@el, @template, @translation) ->
    @proficiency = 1

  updateTranslation: (slider_value) ->
    @proficiency = slider_value/3
    @render()

  render: ->
    @el.html(@template(@translation))
