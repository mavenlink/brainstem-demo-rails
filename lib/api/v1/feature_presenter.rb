module Api
  module V1
    class FeaturePresenter < Brainstem::Presenter
      presents Feature
      
      sort_order :updated_at, "features.updated_at"
      sort_order :created_at, "features.created_at"

      default_sort_order "created_at:desc"

      fields do
        field :name, :string, "the name of this Feature"
        field :updated_at, :datetime, "the time when this Feature was last updated"
        field :created_at, :datetime, "the time when this Feature was created"
      end
      
      associations do
        association :widget, Widget, "the Widget associated with this Feature"
      end
    end
  end
end