class CreateTopicReactions < ActiveRecord::Migration
  def self.up
    create_table :topic_reactions do |t|
      t.references :topic
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :topic_reactions
  end
end
