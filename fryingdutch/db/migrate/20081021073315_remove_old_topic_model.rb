class RemoveOldTopicModel < ActiveRecord::Migration
  def self.up
    drop_table :topic_reactions
    drop_table :topics
  end

  def self.down
    create_table "topic_reactions", :force => true do |t|
      t.integer  "topic_id",         :limit => 11
      t.integer  "user_id",          :limit => 11
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "reaction_on_type"
      t.integer  "reaction_on_id",   :limit => 11
    end
  
    create_table "topics", :force => true do |t|
      t.string   "parent_type"
      t.integer  "parent_id",     :limit => 11
      t.string   "title"
      t.integer  "reactioncount", :limit => 11
      t.string   "topic_type"
      t.integer  "user_id",       :limit => 11
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
