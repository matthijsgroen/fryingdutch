class ReadContent < ActiveRecord::Base
  belongs_to :user
  belongs_to :item, :polymorphic => true
end
