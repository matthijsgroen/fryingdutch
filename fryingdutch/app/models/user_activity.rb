class UserActivity < ActiveRecord::Base
  belongs_to :user
  
  before_save :set_time_spent
  
  def set_time_spent
    self.time_spent = ((self.session_end - self.session_start) / 60.0).ceil
  end  
  
end
