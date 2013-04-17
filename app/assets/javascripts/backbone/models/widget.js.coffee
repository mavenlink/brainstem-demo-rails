window.Models ?= {}
window.Collections ?= {}

class Models.Widget extends Brainstem.Model
  paramRoot: 'widget'
  brainstemKey: 'widgets'
  urlRoot: '/api/v1/widgets'

  @associations:
    features: ["features"]
    location: "locations"

class Collections.Widgets extends Brainstem.Collection
  model: Models.Widget
  url: '/api/v1/widgets'
