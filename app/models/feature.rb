class Feature < ActiveRecord::Base
  attr_accessible :name, :widget, :widget_id

  belongs_to :widget
end