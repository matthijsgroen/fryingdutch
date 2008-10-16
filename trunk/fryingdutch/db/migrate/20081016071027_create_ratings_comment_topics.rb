class CreateRatingsCommentTopics < ActiveRecord::Migration
  def self.up
    create_table :ratings_comment_topics do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :ratings_comment_topics
  end
end
