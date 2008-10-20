class AllowNestedReactions < ActiveRecord::Migration
  def self.up
    add_column :topic_reactions, :reaction_on_type, :string
    add_column :topic_reactions, :reaction_on_id, :integer
  end

  def self.down
    remove_column :topic_reactions, :reaction_on_type
    remove_column :topic_reactions, :reaction_on_id
  end
end
