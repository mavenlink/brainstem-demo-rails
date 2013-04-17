window.Views ?= {}
Views.Widgets ?= {}

class Views.Widgets.WidgetView extends Backbone.View
  template: JST["backbone/templates/widgets/widget"]

  tagName: "li"
  className: "widget"

  initialize: =>
    @model.bind "change", @render
    @model.bind "destroy", => @remove()

  render: =>
    $(@el).html @template(model: @model)
    return this