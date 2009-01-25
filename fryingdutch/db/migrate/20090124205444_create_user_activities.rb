class CreateUserActivities < ActiveRecord::Migration
  def self.up
    create_table :user_activities do |t|
      t.references :user
      t.datetime :session_start
      t.datetime :session_end
      t.datetime :time_spent

      t.timestamps
    end
  end

  def self.down
    drop_table :user_activities
  end
end
