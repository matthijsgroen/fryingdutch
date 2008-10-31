class AddCategoryToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :category, :string, :default => "comment"
  end

  def self.down
    remove_column :comments, :category
  end
end
