window.Routers ?= {}

class Routers.WidgetsRouter extends Backbone.Router
  routes:
    "widgets/new"             : "new"
    "widgets/:id/edit"        : "edit"
    "widgets/:id"             : "show"
    "widgets"                 : "index"

  new: =>
    view = new Views.Widgets.NewView()
    $('#content').html view.render().$el

  index: =>
    view = new Views.Widgets.IndexView()
    $('#content').html(view.render().$el)

  show: (id) =>
    view = new Views.Widgets.ShowView(id: id)
    $('#content').html(view.render().$el)

  edit: (id) =>
    view = new Views.Widgets.EditView(id: id)
    $('#content').html(view.render().$el)
