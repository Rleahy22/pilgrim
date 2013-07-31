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

  window.article.render()

window.Article = class Article
  constructor: (@el, @template, @translation) ->
    @proficiency = 1

  updateTranslation: (slider_value) ->
    @proficiency = slider_value/3
    @render()

  render: ->
    @el.html(@template(@translation))
