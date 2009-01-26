class CreateMessageLabels < ActiveRecord::Migration
  def self.up
    create_table :message_labels do |t|
      t.references :user
      t.string :label
      t.boolean :system_label

      t.timestamps
    end
  end

  def self.down
    drop_table :message_labels
  end
end
