class CreateTextComments < ActiveRecord::Migration
  def self.up
    create_table :text_comments do |t|
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :text_comments
  end
end
