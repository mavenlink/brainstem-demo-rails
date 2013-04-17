module Api
  module V1
    class FeaturePresenter < Brainstem::Presenter
      presents "Feature"

      sort_order :updated_at, "features.updated_at"
      sort_order :created_at, "features.created_at"

      default_sort_order "created_at:desc"

      def present(feature)
        {
            :id             => feature.id,
            :updated_at     => feature.updated_at,
            :created_at     => feature.created_at,
            :name           => feature.name,
            :widget         => association(:widget)
        }
      end
    end
  end
end