class CreateUserGames < ActiveRecord::Migration
  def self.up
    create_table :user_games do |t|
      t.references :game
      t.references :user
      t.date :start_date
      t.date :end_date
      t.integer :quit_reason
      t.string :quit_details

      t.timestamps
    end
  end

  def self.down
    drop_table :user_games
  end
end
