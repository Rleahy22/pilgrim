parsed = {}


$.getJSON '/test', (data) ->
	parsed = data


$ ->
	template = Handlebars.compile($('#text').html())
	$('#language').on 'change', ->
		console.log(parsed)
		$('#article').append(template(parsed))
