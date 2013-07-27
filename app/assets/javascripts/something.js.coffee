parsed = {}


$.getJSON '/test', (data) ->
	parsed = data


$ ->
	template = Handlebars.compile($('#text').html())
	$('#language').on 'change', ->
		console.log(parsed)
		# parsed = {words: [{yo: "Hello"}, {yo: "World"}]}
		# console.log(parsed)
		$('#article').append(template(parsed))
