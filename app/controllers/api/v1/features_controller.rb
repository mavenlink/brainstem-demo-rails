module Api
  module V1
    class FeaturesController < ApiController
      before_filter :load_feature, :only => [:show, :update, :destroy]

      def index
        render :json => present("features") {
          Feature.unscoped
        }
      end

      def show
        render :json => present_object(@feature)
      end

      def create
        @feature = Feature.create(params[:feature])
        if @feature.save
          render :json => present_object(@feature)
        else
          render :json => {:errors => @feature.errors.full_messages}, :status => :unprocessable_entity
        end
      end

      def update
        if @feature.update_attributes(params[:feature])
          render :json => present_object(@feature)
        else
          render :json => {:errors => @feature.errors.full_messages}, :status => :unprocessable_entity
        end
      end

      def destroy
        @feature.destroy
        render :json => { :success => true }
      end

      protected

      def load_feature
        @feature = Feature.find(params[:id])
      end
    end
  end
end
