module Api
  module V1
    class LocationsController < ApiController
      def index
        render :json => present("locations") {
          # Return an ARel scope on which all further filtering will be applied.
          # For example:
          #  Location.relavent_for_api
          #  Location.visible_to(current_user)
          #  Location.in_the_united_states
          Location.unscoped
        }
      end

      def show
        render :json => present_object(Location.find(params[:id]))
      end
    end
  end
end