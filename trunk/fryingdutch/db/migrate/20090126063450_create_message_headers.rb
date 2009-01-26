class CreateMessageHeaders < ActiveRecord::Migration
  def self.up
    create_table :message_headers do |t|
      t.references :from, :polymorphic => true, :nil => false
      t.string :subject, :nil => false
      t.references :content, :polymorphic => true, :nil => false

      t.timestamps
    end
  end

  def self.down
    drop_table :message_headers
  end
end
