class RatingComment < ActiveRecord::Base

  has_one :comment, :as => :content
  delegate :user, :created_on, :updated_on, :comment_on, :to => :comment

end
