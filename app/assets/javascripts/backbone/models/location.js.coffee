window.Models ?= {}
window.Collections ?= {}

class Models.Location extends Brainstem.Model
  paramRoot: 'location'
  brainstemKey: 'locations'
  urlRoot: '/api/v1/locations'

  @associations:
    widgets: ["widgets"]

class Collections.Locations extends Brainstem.Collection
  model: Models.Location
  url: '/api/v1/locations'
