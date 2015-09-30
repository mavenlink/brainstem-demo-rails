module Api
  module V1
    class WidgetPresenter < Brainstem::Presenter
      presents Widget

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
        scope.where(location_id: location_id)
      end

      # Filter with an overridable default that runs on all requests.
      filter :include_legacy_widgets, default: false do |scope, bool|
        bool ? scope : scope.without_legacy_widgets
      end

      # This is where you would wire in your search system, such as elasticsearch or solr.
      search do |search_string, options|
        scope = Widget.where("name like ?", "%#{search_string}%")

        if options[:location_id]
          scope = scope.where(location_id: options[:location_id])
        end

        results = scope.pluck('id')
        [results, results.count]

        # if robust_search_system_is_down?
        #  [false, 0]
        # end
      end

      fields do
        field :name, :string, "this Widget's name"
        field :legacy, :boolean, "whether or not this is a legacy Widget", via: :legacy?
        field :updated_at, :datetime, "the time when this Widget was last updated"
        field :created_at, :datetime, "the time when this Widget was created"
      end
      
      associations do
        association :features, Feature, "this Widget's Features"
        association :location, Location, "this Widget's Location"
      end
    end
  end
end
