class AddPermalinkToBoard < ActiveRecord::Migration
  def self.up
    add_column :boards, :permalink, :string
  end

  def self.down
    remove_column :boards, :permalink
  end
end
