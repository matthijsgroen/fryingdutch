class TimeSpent < ActiveRecord::Migration
  def self.up
    change_column :user_activities, :time_spent, :integer
  end

  def self.down
    change_column :user_activities, :time_spent, :datetime
  end
end
