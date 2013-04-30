# Brainstem and Brainstem.js Demo Rails Project

[Brainstem](https://github.com/mavenlink/brainstem) is a presenter and API library for Rails.  [Brainstem.js](https://github.com/mavenlink/brainstem-js) is a library for Backbone.js that adds the concept of relational models and makes working with Brainstem APIs easy.

This demo project shows off some of the features of Brainstem and Brainstem.js.

## Setup the Demo

    rake db:create db:migrate
    rake db:seed
    rails s

Then visit [localhost:3000](http://localhost:3000) to play with the app.

## Explore the Source

### A Brainstem API

* To get started with Brainstem in Rails, take a look at [config/initializers/brainstem.rb](config/initializers/brainstem.rb).
* From there, skim the [example presenters in lib/api/v1](lib/api/v1).
* Finally, check out the [API controllers in app/controllers/api/v1](app/controllers/api/v1).

### Using the API from Backbone with Brainstem.js

* All of the Backbone code is in [app/assets/javascripts/backbone](app/assets/javascripts/backbone).
* Start by skimming the [models](app/assets/javascripts/backbone/models), then
* checkout how we setup the [base application in application.js.coffee](app/assets/javascripts/application.js.coffee).
* Finally, checkout the [views](app/assets/javascripts/backbone/views/widgets) and eco [templates](app/assets/javascripts/backbone/templates) to see Brainstem.js in action.

# Contributing

Find a bug?  Have an idea about how to expand this demo?  Send us a pull request!

# License

This demo, Brainstem, and Brainstem.js are available under the [MIT License](LICENSE).
