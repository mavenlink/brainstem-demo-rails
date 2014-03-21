class ApiController < ApplicationController
  include Brainstem::ControllerMethods

  before_filter :api_authenticate, :except => [:page_not_found]

  rescue_from Brainstem::SearchUnavailableError, :with => :search_unavailable
  rescue_from ActiveRecord::RecordNotFound,
              ActionController::RoutingError,
              ::AbstractController::ActionNotFound, :with => :page_not_found

  unless Rails.env.test? || Rails.env.development?
    rescue_from StandardError, :with => :server_error
  end

  protected

  def api_authenticate
    # Authenticate the user as appropriate.  Doorkeeper is a good option if you want to build an oauth2 API.
  end

  def server_error(exception)
    render :json => system_error_json("A server error has occurred."), :status => 500
  end

  def page_not_found
    render :json => system_error_json("Page not found"), :status => 404
  end

  def search_unavailable
    render :json => system_error_json("Search is currently unavailable"), :status => 503
  end

  # The following methods will likely be pulled into Brainstem::ControllerMethods soon.

  def render_api_index(name, options = {}, &scope)
    render :json => present(name, options, &scope)
  end

  def render_api_model(model, options = {})
    render :json => present_object(model, options)
  end

  # This method will raise an ActiveRecord::RecordNotFound error when no model exists, instead of giving an empty set.
  # Use this for show actions.
  def render_api_model!(model, options = {})
    render_api_model(model, options.merge(:raise_on_empty => true))
  end

  def render_api_errors(model)
    render :json => model_error_json(model), :status => :unprocessable_entity
  end

  def system_error_json(*messages)
    options = messages.last.is_a?(Hash) ? messages.pop : {}
    json = { :errors => [] }
    messages.flatten.uniq.each do |message|
      json[:errors] << {
        :type => options[:type] || :system,
        :message => message
      }
    end
    json
  end

  # Given a model, outputs API-style, for example:
  #  { :errors => [{ :type => :validation, :field => :model_id, :message => "Model is required" }] }
  # If given a rewrite_params hash, it will convert from internal column names to external names.
  def model_error_json(object_or_objects, options = {})
    json = { :errors => [] }

    [object_or_objects].flatten.each do |object|
      if object.is_a?(Hash)
        attribute = object[:field] || :base
        json[:errors] << {
          :type => object[:type] || :validation,
          :field => (options[:rewrite_params] || {}).reverse_merge(attribute => attribute).invert[attribute],
          :message => object[:message] || raise(ArgumentError, "message required")
        }
      elsif object.is_a?(String)
        json[:errors] << { :type => :validation, :field => :base, :message => object }
      else
        object.errors.each do |attribute, attribute_error|
          json[:errors] << {
            :type => :validation,
            :field => (options[:rewrite_params] || {}).reverse_merge(attribute => attribute).invert[attribute],
            :message => full_message(object, attribute, attribute_error)
          }
        end
      end
    end
    json
  end

  # Helper to convert an attribute name (e.g., "story_id") and error (e.g., "is invalid") into a combined full message.
  # Also handles traditional "^You messed up"-style errors that should not be combined with humanized attribute names.
  def full_message(object, attribute, text)
    text[0] == "^" ? text[1..-1] : object.errors.full_message(attribute, text)
  end
end
