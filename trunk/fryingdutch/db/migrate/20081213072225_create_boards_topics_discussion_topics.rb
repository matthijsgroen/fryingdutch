class CreateBoardsTopicsDiscussionTopics < ActiveRecord::Migration
  def self.up
    create_table :discussion_topics do |t|
      t.string :title
      t.references :icon
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :discussion_topics
  end
end
