module Api
  module V1
    class FeaturesController < ApiController
      before_filter :load_feature, :only => [:show, :update, :destroy]

      def index
        render_api_index("features") {
          Feature.unscoped
        }
      end

      def show
        render_api_model!(@feature)
      end

      def create
        @feature = Feature.create(params[:feature])
        if @feature.save
          render_api_model(@feature)
        else
          render_api_errors(@feature)
        end
      end

      def update
        if @feature.update_attributes(params[:feature])
          render_api_model(@feature)
        else
          render_api_errors(@feature)
        end
      end

      def destroy
        @feature.destroy
        head 204
      end

      protected

      def load_feature
        @feature = Feature.find(params[:id])
      end
    end
  end
end
