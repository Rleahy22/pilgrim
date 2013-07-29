template = {}
parsed = {}
proficiency = 1

updateArticle = (value) ->
  proficiency = value/3
  $('#article').html(template(parsed))

Handlebars.registerHelper "checkProficiency", (level, options) ->
  console.log("Meow.")
  if level >= proficiency
    console.log("Meow.")
    return options.fn(this)
  return options.inverse(this)

$ ->
  template = Handlebars.compile($('#text').html())
  article = $('[data-parsed-article]').text()
  parsed = {words: JSON.parse(article)}
  console.log parsed
  $('#article').html(template(parsed))

  $('#slider').slider
    value:1
    min:1
    max:90
    step:1
    slide: (event, ui) ->
      console.log(ui.value)
      updateArticle(ui.value)
