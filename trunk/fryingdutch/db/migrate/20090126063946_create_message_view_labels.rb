class CreateMessageViewLabels < ActiveRecord::Migration
  def self.up
    create_table :message_view_labels do |t|
      t.references :message_view, :nil => false
      t.references :label, :nil => false

      t.timestamps
    end
  end

  def self.down
    drop_table :message_view_labels
  end
end
