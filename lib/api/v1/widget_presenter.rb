module Api
  module V1
    class WidgetPresenter < Brainstem::Presenter
      presents "Widget"

      # Available sort orders to expose through the API
      sort_order :updated_at, "widgets.updated_at"
      sort_order :created_at, "widgets.created_at"

      # Default sort order to apply
      default_sort_order "updated_at:desc"

      # Optional filter that applies a lambda.
      filter :location_name do |scope, location_name|
        scope.joins(:location).where("locations.name = ?", location_name)
      end

      # Optional filter that applies a lambda.
      filter :location_id do |scope, location_id|
        scope.where(:location_id => location_id)
      end

      # Filter with an overridable default that runs on all requests.
      filter :include_legacy_widgets, :default => false do |scope, bool|
        bool ? scope : scope.without_legacy_widgets
      end

      # This is where you would wire in your search system, such as Elastcsearch or Solr.
      search do |search_string, options|
        scope = Widget.where("name like '%#{search_string}%'")

        if options[:location_id]
          scope = scope.where(:location_id => options[:location_id])
        end

        results = scope.pluck('id')
        [results, results.count]

        # if robust_search_system_is_down?
        #  [false, 0]
        # end
      end

      # Return a ruby hash that can be converted to JSON
      def present(widget)
        {
            :name           => widget.name,
            :legacy         => widget.legacy?,
            :updated_at     => widget.updated_at,
            :created_at     => widget.created_at,
            # Associations can be included by request
            :features       => association(:features),
            :location       => association(:location)
        }
      end
    end
  end
end
