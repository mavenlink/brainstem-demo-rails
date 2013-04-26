window.Views ?= {}
Views.Widgets ?= {}

class Views.Widgets.IndexView extends Backbone.View
  template: JST["backbone/templates/widgets/index"]

  events:
    "change #location": "filter"

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
    @addLocations()

  addOne: (model) =>
    view = new Views.Widgets.WidgetView(model: model)
    @$("#widgets-list").append view.render().el

  filter: (e) =>
    e.preventDefault()
    id = @$("#location").val()
    if id > 0
      filters = { location_id: id }
    else
      filters = null
    base.data.loadCollection "widgets",
                             collection: @collection,
                             reset: true,
                             filters: filters,
                             include: ["location", "features"],
                             order: 'updated_at:desc'

  addLocations: =>
    if @$("#location option").length == 0
      base.data.loadCollection "locations", success: (collection) =>
        @$("#location").append $("<option></option>").val(-1).text("Any Location")
        collection.each (model) =>
          @$("#location").append $("<option></option>").val(model.get("id")).text(model.get("name"))
