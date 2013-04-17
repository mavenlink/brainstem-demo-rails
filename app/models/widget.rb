class Widget < ActiveRecord::Base
  attr_accessible :name, :legacy, :location

  belongs_to :location
  has_many :features

  scope :without_legacy_widgets, where(:legacy => false)
end