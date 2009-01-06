class AddCategoryToReading < ActiveRecord::Migration
  def self.up
    add_column :read_contents, :category, :string
  end

  def self.down
    remove_column :read_contents, :category
  end
end
