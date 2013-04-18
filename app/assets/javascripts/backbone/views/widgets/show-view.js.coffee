window.Views ?= {}
Views.Widgets ?= {}

class Views.Widgets.ShowView extends Backbone.View
  template: JST["backbone/templates/widgets/show"]

  initialize: ->
    @model = base.data.loadModel "widget", @id, include: ["location", "features"]
    @model.bind 'loaded', @render

  render: =>
    @$el.html @template(model: @model)
    return this
