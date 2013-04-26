module Api
  module V1
    class LocationPresenter < Brainstem::Presenter
      presents "Location"

      sort_order :id, "locations.id"
      sort_order :created_at, "locations.created_at"

      default_sort_order "id:desc"

      def present(location)
        {
            :name           => location.name,
            :widgets        => association(:widgets)
        }
      end
    end
  end
end