Handlebars.registerHelper "showSourceLanguage", (level, options) ->
  if level >= window.currentArticle.proficiency
    return options.fn(this)
  return options.inverse(this)

$ ->
  template = Handlebars.compile($('#text-template').html())
  articleJson = $('[data-parsed-article]').text()
  translation = {words: JSON.parse(articleJson)}

  window.currentArticle = new Article($("#article"), template, translation)


  $('body').on 'change', '#slider', ->
    console.log("Meow.")
    window.currentArticle.updateTranslation $('#slider').val()

  $('#language').val($('#slider').data('source'))

  $('#article').on 'mouseenter', '.foreign', ->
    current = $(this)
    word = current.html()
    source = $('#article').data('source')
    target = $('#slider').data('source')
    $.getJSON 'https://www.googleapis.com/language/translate/v2?key=AIzaSyALN7om8pcP6n5BhSB0v9K23KQB4B1mefo&q=' + word + '&source=' + target + '&target=' + source, (data) ->
      replacement = data.data["translations"][0]["translatedText"]
      current.html replacement
      current.css "background-color", "#B8B8B8"
    $('#article').on 'mouseleave', '.foreign', ->
      current.css "background-color", "transparent"
      current.html word

  window.currentArticle.render()

  $('#question').on 'mouseenter', ->
    $('#how_to').css "visibility", "visible"
    $('#question').on 'mouseleave', ->
      $('#how_to').css "visibility", "hidden"

window.Article = class Article
  constructor: (@el, @template, @translation) ->
    @proficiency = 1

  updateTranslation: (slider_value)->
    @proficiency = slider_value
    @render()

  render: ->
    @el.html(@template(@translation))
