//= require pilgrim

describe "Article", ->
  article = null
  beforeEach ->
    el = $('<div id="article">what</div>')
    template = Handlebars.compile("")
    translation = {"0": {source: "the", target: "le", level: 1}}
    article = new Article(el, template, translation)
    spyOn(article, "render")

  describe "Article", ->
    it "defaults to a proficiency of one", ->
      expect(article.proficiency).toEqual 1

  describe "updateTranslation", ->
    it "should set proficiency equal to a third of the value of the slider", ->
      article.updateTranslation(9)
      expect(article.proficiency).toEqual 3

    it "should call render", ->
      article.updateTranslation(3)
      expect(article.render).toHaveBeenCalled()
