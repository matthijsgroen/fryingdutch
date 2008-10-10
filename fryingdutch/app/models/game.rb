class Game < ActiveRecord::Base

  validates_uniqueness_of :name
  validates_presence_of :description
  acts_as_taggable

end
