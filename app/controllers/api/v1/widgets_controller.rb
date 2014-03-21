module Api
  module V1
    class WidgetsController < ApiController
      before_filter :load_widget, :only => [:show, :update, :destroy]

      def index
        render_api_index("widgets") {
          # Return an ARel scope on which all further filtering will be applied.
          # For example:
          #  Widget.relavent_for_api
          #  Widget.visible_to(current_user)
          #  Widget.not_archived
          Widget.unscoped
        }
      end

      def show
        render_api_model!(@widget)
      end

      def create
        @widget = Widget.create(params[:widget])
        if @widget.save
          render_api_model(@widget)
        else
          render_api_errors(@widget)
        end
      end

      def update
        if @widget.update_attributes(params[:widget])
          render_api_model(@widget)
        else
          render_api_errors(@widget)
        end
      end

      def destroy
        @widget.destroy
        head 204
      end

      protected

      def load_widget
        @widget = Widget.find(params[:id])
      end
    end
  end
end
