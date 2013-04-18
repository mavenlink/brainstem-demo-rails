window.Views ?= {}
Views.Widgets ?= {}

class Views.Widgets.NewView extends Backbone.View
  template: JST["backbone/templates/widgets/new"]

  events:
    "submit form": "submit"

  render: =>
    @$el.html @template()
    @addLocations()
    return this

  submit: (e) =>
    e.preventDefault()
    model = new Models.Widget()
    attributes = { name: @$("form input#name").val(), location_id: @$("form select").val() }
    model.save attributes, success: =>
      base.data.reset() # Clear the Brainstem cache so that the newly created value shows up.
      base.homeRouter.navigate "/widgets", true

  addLocations: =>
    base.data.loadCollection "locations", success: (collection) =>
      collection.each (model) =>
        @$("#location").append $("<option></option>").val(model.get("id")).text(model.get("name"))