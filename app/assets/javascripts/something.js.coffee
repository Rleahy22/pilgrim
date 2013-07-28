template = {}
parsed = {}
proficiency = 1

updateArticle = (value) ->
	proficiency = value
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
    max:10
    step:1
    slide: (event, ui) ->
    	updateArticle(ui.value)

	$('#language').on 'change', ->
		$('#article').html(template(parsed))
