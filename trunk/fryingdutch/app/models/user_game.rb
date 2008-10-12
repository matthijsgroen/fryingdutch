class UserGame < ActiveRecord::Base

  belongs_to :user
  belongs_to :game
  validates_presence_of :start_date
  
end
