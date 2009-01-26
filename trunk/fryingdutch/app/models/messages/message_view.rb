class Messages::MessageView < ActiveRecord::Base
  belongs_to :user
  belongs_to :message_header
end
