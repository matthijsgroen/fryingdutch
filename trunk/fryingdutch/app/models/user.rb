class User < ActiveRecord::Base

  has_many :user_games, :dependent => :destroy
  
  has_many :user_games_playing, :class_name => "UserGame", :conditions => "user_games.end_date IS NULL"
  has_many :games_playing, :class_name => "Game", :through => :user_games_playing, :source => :game

  def before_save
    self.permalink = "#{nickname.gsub(/[^a-z0-9]+/i, '-')}".downcase if self.nickname
  end

  def to_param
    return permalink if permalink
    save
    permalink
  end

end
