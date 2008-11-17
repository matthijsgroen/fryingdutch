class WowCharacter < ActiveRecord::Base
  
  belongs_to :user
  validates_presence_of :name, :realm
  
end
