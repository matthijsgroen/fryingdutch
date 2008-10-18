class DropTableReactionTopic < ActiveRecord::Migration
  def self.up
    drop_table :ratings_comment_topics
  end

  def self.down
    create_table :ratings_comment_topics do |t|
      t.timestamps
    end
  end
end
