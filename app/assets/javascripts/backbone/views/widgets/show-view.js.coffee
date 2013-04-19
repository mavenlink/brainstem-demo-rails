window.Views ?= {}
Views.Widgets ?= {}

class Views.Widgets.ShowView extends Backbone.View
  template: JST["backbone/templates/widgets/show"]

  events:
    "click .feature.editable a.save"    : "saveFeature"
    "click .feature.editable a.delete"  : "deleteFeature"
    "submit .feature.editable form"     : "saveFeature"

  initialize: ->
    @loadModel()

  loadModel: =>
    # Load a single Widget by id, including its associated Location and Features.  Call #render when the data is ready.
    @model = base.data.loadModel "widget", @id, include: ["location", "features"]
    if @model.loaded
      @render
    else
      @model.bind 'loaded', @render

  reloadModel: =>
    console.log "reloadModel"
    base.data.reset() # Clear the Brainstem cache so that the newly created / updated / deleted Feature shows up on this Widget.
                      # In the future Brainstem.Models will likely have a #reload method to simplify this flow.
    @loadModel()

  render: =>
    @$el.html @template(model: @model)
    return this

  saveFeature: (e) =>
    e.preventDefault()
    name = $(e.target).closest("li.feature").find("input[name='name']").val()
    id = $(e.target).closest("li.feature").find("input[name='id']").val()
    feature = if id then @model.get("features").get(id) else new Models.Feature()
    feature.save { widget_id: @model.get("id"), name: name }, success: @reloadModel

  deleteFeature: (e) =>
    e.preventDefault()
    id = $(e.target).closest("li.feature").find("input[name='id']").val()
    if id
      @model.get("features").get(id).destroy success: @reloadModel
