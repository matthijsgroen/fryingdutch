class Comment < ActiveRecord::Base

  belongs_to :comment_on, :polymorphic => true
  belongs_to :content, :polymorphic => true, :dependent => :destroy
  belongs_to :user
  
  acts_as_list :scope => :comment_on

end
