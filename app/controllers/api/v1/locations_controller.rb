module Api
  module V1
    class LocationsController < ApiController
      def index
        render_api_index("locations") {
          # Return an ARel scope on which all further filtering will be applied.
          # For example:
          #  Location.relavent_for_api
          #  Location.visible_to(current_user)
          #  Location.in_the_united_states
          Location.unscoped
        }
      end

      def show
        render_api_model!(Location.find(params[:id]))
      end
    end
  end
end