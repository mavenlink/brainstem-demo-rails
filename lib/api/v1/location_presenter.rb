module Api
  module V1
    class LocationPresenter < Brainstem::Presenter
      presents Location

      sort_order :id, "locations.id"
      sort_order :created_at, "locations.created_at"

      default_sort_order "id:desc"

      fields do
        field :name, :string, "this Location's name"
      end
      
      associations do
        association :widgets, Widget, "the Widgets at this Location"
      end
    end
  end
end