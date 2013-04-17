class ApiController < ApplicationController
  include Brainstem::ControllerMethods

  before_filter :api_authenticate, :except => [:page_not_found]

  rescue_from ActiveRecord::RecordNotFound,
              ActionController::RoutingError,
              ::AbstractController::ActionNotFound, :with => :page_not_found

  protected

  def page_not_found
    render :json => { :errors => ['Page not found'] }, :status => 404
  end

  def api_authenticate
    # Authenticate the user as appropriate.  Doorkeeper is a good option if you want to build an oauth2 API.
  end
end