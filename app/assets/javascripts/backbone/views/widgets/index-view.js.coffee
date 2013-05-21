window.Views ?= {}
Views.Widgets ?= {}

class Views.Widgets.IndexView extends Backbone.View
  template: JST["backbone/templates/widgets/index"]

  events:
    "change #location": "filter"
    "keyup #search":    "filter"

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
    query = @$("#search").val()

    options = {}
    options.collection = @collection
    options.reset = true
    options.include = ["location", "features"]
    options.filters = { location_id: id } if id > 0
    options.search = query if query

    base.data.loadCollection "widgets", options

  addLocations: =>
    if @$("#location option").length == 0
      base.data.loadCollection "locations", success: (collection) =>
        @$("#location").append $("<option></option>").val(-1).text("Any Location")
        collection.each (model) =>
          @$("#location").append $("<option></option>").val(model.get("id")).text(model.get("name"))
