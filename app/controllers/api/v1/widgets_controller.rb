module Api
  module V1
    class WidgetsController < ApiController
      before_filter :load_widget, :only => [:show, :update, :destroy]

      def index
        render :json => present("widgets") {
          # Return an ARel scope on which all further filtering will be applied.
          # For example:
          #  Widget.relavent_for_api
          #  Widget.visible_to(current_user)
          #  Widget.not_archived
          Widget.unscoped
        }
      end

      def show
        render :json => present_object(@widget)
      end

      def create
        @widget = Widget.create(params[:widget])
        if @widget.save
          render :json => present_object(@widget)
        else
          render :json => {:errors => @widget.errors.full_messages}, :status => :unprocessable_entity
        end
      end

      def update
        if @widget.update_attributes(params[:widget])
          render :json => present_object(@widget)
        else
          render :json => {:errors => @widget.errors.full_messages}, :status => :unprocessable_entity
        end
      end

      def destroy
        @widget.destroy
        render :json => { :success => true }
      end

      protected

      def load_widget
        @widget = Widget.find(params[:id])
      end
    end
  end
end
