window.Routers ?= {}

class Routers.WidgetsRouter extends Backbone.Router
  routes:
    "widgets"                 : "index"
    "widgets/new"             : "new"
    "widgets/:id"             : "show"
    "*path"                   : "redirectToWidgets"

  new: =>
    view = new Views.Widgets.NewView()
    $('#content').html view.render().$el

  index: =>
    view = new Views.Widgets.IndexView()
    $('#content').html(view.render().$el)

  show: (id) =>
    view = new Views.Widgets.ShowView(id: id)
    $('#content').html(view.render().$el)

  redirectToWidgets: =>
    @navigate "/widgets", true
