class AddLoginCounterToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :login_counter, :integer
  end

  def self.down
    remove_column :users, :login_counter
  end
end
