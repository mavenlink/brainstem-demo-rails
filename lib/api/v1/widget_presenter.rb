module Api
  module V1
    class WidgetPresenter < Brainstem::Presenter
      presents "Widget"

      sort_order :updated_at, "widgets.updated_at"
      sort_order :created_at, "widgets.created_at"

      default_sort_order "updated_at:desc"

      filter :location_name do |scope, location_name|
        scope.joins(:locations).where("locations.name = ?", location_name)
      end

      filter :include_legacy_widgets, :default => false do |scope, bool|
        bool ? scope : scope.without_legacy_widgets
      end

      def present(widget)
        {
            :id             => widget.id,
            :name           => widget.name,
            :legacy         => widget.legacy?,
            :updated_at     => widget.updated_at,
            :created_at     => widget.created_at,
            :features       => association(:features),
            :location       => association(:location)
        }
      end
    end
  end
end