translate = (source) ->
  word = ($(source).html())
  # $.getJSON('https://www.googleapis.com/language/translate/v2?key=AIzaSyALN7om8pcP6n5BhSB0v9K23KQB4B1mefo&q=' + word + '&source=en&target=es', (data) ->
  #   replacement = (data.data["translations"][0]["translatedText"])
  #   $(source).html(replacement)
  $(source).effect("highlight", {color:"#DCDCDC"}, 1000)
  $(source).css("font-weight", "bold")
  # )

identify = (proficiency) ->
  if proficiency == 1
    arr = $('.class1')
  else if proficiency == 2
    arr = $('.class3')
  else if proficiency == 3
    arr = $('.class2')
  else if proficiency == 4
    arr = $('.class4')

  _.each(arr, translate)

$ ->
  $('#slider').slider(
    value:0
    min:0
    max:4
    step:1
    slide: (event, ui) ->
      identify(ui.value)
  )
