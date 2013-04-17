window.Models ?= {}
window.Collections ?= {}

class Models.Feature extends Brainstem.Model
  paramRoot: 'feature'
  brainstemKey: 'features'
  urlRoot: '/api/v1/features'

  @associations:
    widgets: ["widgets"]

class Collections.Features extends Brainstem.Collection
  model: Models.Feature
  url: '/api/v1/features'
