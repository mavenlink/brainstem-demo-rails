window.Views ?= {}
Views.Widgets ?= {}

class Views.Widgets.NewView extends Backbone.View
  template: JST["backbone/templates/widgets/new"]

  render: =>
    @$el.html @template()
    return this
