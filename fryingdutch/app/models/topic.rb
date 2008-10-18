class Topic < ActiveRecord::Base

  has_many :topic_reactions
  belongs_to :parent, :polymorphic => true
  validates_presence_of :user_id, :title

end
