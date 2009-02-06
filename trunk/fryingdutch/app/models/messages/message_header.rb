class Messages::MessageHeader < ActiveRecord::Base
  
  belongs_to :from, :polymorphic => true
  belongs_to :content, :polymorphic => true
  
  attr_accessor :to
  
end
