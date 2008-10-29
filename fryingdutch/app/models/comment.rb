class Comment < ActiveRecord::Base

  belongs_to :comment_on, :polymorphic => true
  belongs_to :content, :polymorphic => true, :dependent => :destroy
  belongs_to :user

end
