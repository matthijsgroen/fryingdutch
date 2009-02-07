class ObjectState < ActiveRecord::Base
  belongs_to :object, :polymorphic => true
  belongs_to :owner, :class_name => "User"
end
