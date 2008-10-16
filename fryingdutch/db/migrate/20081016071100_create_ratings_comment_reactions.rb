class CreateRatingsCommentReactions < ActiveRecord::Migration
  def self.up
    create_table :ratings_comment_reactions do |t|
      t.float :rating
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :ratings_comment_reactions
  end
end
