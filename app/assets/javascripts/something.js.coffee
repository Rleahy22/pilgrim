template = {}
parsed = {}
proficiency = 1

updateArticle = (value) ->
	proficiency = value/3
	$('#article').html(template(parsed))

Handlebars.registerHelper "checkProficiency", (level, options) ->
	if level >= proficiency
		return options.fn(this)
	return options.inverse(this)

$ ->
	template = Handlebars.compile($('#text').html())

	$.getJSON '/test', (data) ->
		parsed = data
		$('#article').html(template(parsed))

  $('#slider').slider
    value:1
    min:1
    max:90
    step:1
    slide: (event, ui) ->
    	updateArticle(ui.value)

	$('#language').on 'change', ->
    target = $(this).val()
    $.getJSON 'https://www.googleapis.com/language/translate/v2?key=AIzaSyALN7om8pcP6n5BhSB0v9K23KQB4B1mefo&q=' + 'word' + '&source=en&target=' + target , (data) ->
      replacement = (data.data["translations"][0]["translatedText"])
      console.log(replacement)
      # $(source).html(replacement)
		$('#article').html(template(parsed))
