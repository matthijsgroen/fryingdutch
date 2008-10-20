class TopicReaction < ActiveRecord::Base
  
  belongs_to :topic
  belongs_to :reaction_on, :polymorphic => true
  
end
