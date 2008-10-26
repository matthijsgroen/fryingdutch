class SetNewRatingAndCommentTables < ActiveRecord::Migration
  def self.up
    drop_table :ratings_comment_reactions
    drop_table :rating_comments
  end

  def self.down

    create_table :rating_comments do |t|
      t.float :rating
      t.text :comment
      t.timestamps
    end
  
    create_table :ratings_comment_reactions do |t|
      t.float :rating
      t.text :comment
      t.timestamps
    end

  end
end
