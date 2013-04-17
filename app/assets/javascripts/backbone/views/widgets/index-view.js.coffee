window.Views ?= {}
Views.Widgets ?= {}

class Views.Widgets.IndexView extends Backbone.View
  template: JST["backbone/templates/widgets/index"]

  initialize: ->
    @collection = base.data.loadCollection "widgets", include: ["location", "features"], order: 'updated_at:desc'
    @collection.bind 'reset', @addAll
    @collection.bind 'remove', @addAll

  render: =>
    @$el.html @template()

    if @collection.loaded
      @addAll()
    else
      @$("#widgets-list").text "Just a moment..."

    return this

  addAll: =>
    @$("#widgets-list").empty()
    @collection.each(@addOne)

  addOne: (model) =>
    view = new Views.Widgets.WidgetView(model: model)
    @$("#widgets-list").append view.render().el
