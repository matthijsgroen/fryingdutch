class ChangeQuitReasonToString < ActiveRecord::Migration
  def self.up
    change_column :user_games, :quit_reason, :string
  end

  def self.down
    change_column :user_games, :quit_reason, :integer
  end
end
