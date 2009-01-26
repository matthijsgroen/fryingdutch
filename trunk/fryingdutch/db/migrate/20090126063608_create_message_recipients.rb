class CreateMessageRecipients < ActiveRecord::Migration
  def self.up
    create_table :message_recipients do |t|
      t.references :message_header, :nil => false
      t.references :recipient, :polymorphic => true, :nil => false

      t.timestamps
    end
  end

  def self.down
    drop_table :message_recipients
  end
end
