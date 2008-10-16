class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string :parent_type
      t.integer :parent_id
      t.string :title
      t.integer :reactioncount
      t.string :topic_type
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :topics
  end
end
