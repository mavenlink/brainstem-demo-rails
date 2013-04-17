class Feature < ActiveRecord::Base
  attr_accessible :name, :widget

  belongs_to :widget
end