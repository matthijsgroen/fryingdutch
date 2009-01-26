class ExtendMessagesForDraftsAndFlags < ActiveRecord::Migration
  def self.up
    add_column :message_headers, :draft, :boolean, :default => true
    add_column :message_headers, :allow_reply, :boolean, :default => true
  end

  def self.down
  end
end
