class Comment < ActiveRecord::Base

  belongs_to :comment_on, :polymorphic => true
  belongs_to :content, :polymorphic => true
  has_one :user

end
