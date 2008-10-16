class Topic < ActiveRecord::Base

  has_many :topic_reactions
  belongs_to :topicable, :polymorphic => true

end
