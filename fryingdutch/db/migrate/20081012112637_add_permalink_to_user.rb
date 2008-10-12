class AddPermalinkToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :permalink, :string
    add_column :games, :permalink, :string
  end

  def self.down
    remove_column :users, :permalink
    remove_column :games, :permalink
  end
end
