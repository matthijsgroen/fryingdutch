class CreateMessageViews < ActiveRecord::Migration
  def self.up
    create_table :message_views do |t|
      t.references :user, :nil => false
      t.references :message_header, :nil => false
      t.boolean :read_status
      t.boolean :sent_status

      t.timestamps
    end
  end

  def self.down
    drop_table :message_views
  end
end
