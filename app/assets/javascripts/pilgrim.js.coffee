$ ->
  proficiency = 1
  template = Handlebars.compile($('#text-template').html())
  article = $('[data-parsed-article]').text()
  parsed = {words: JSON.parse(article)}

  updateArticle = (slider_value, template, parsed) ->
    proficiency = slider_value/3
    $('#article').html(template(parsed))

  Handlebars.registerHelper "showSourceLanguage", (level, options) ->
    if level >= proficiency
      return options.fn(this)
    return options.inverse(this)

  $('#article').html(template(parsed))

  $('#slider').slider
    value:1
    min:1
    max:90
    step:1
    slide: (event, ui) ->
      updateArticle(ui.value, template, parsed)
