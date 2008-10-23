class User < ActiveRecord::Base

  SYSTEM = 1; # UserID of the system User.

  has_many :user_games, :dependent => :destroy
  
  has_many :user_games_playing, :class_name => "UserGame", :conditions => "user_games.end_date IS NULL"
  has_many :games_playing, :class_name => "Game", :through => :user_games_playing, :source => :game

  def before_save
    self.permalink = create_permalink 
  end
  
  def after_create
    self.permalink = create_permalink
    save
  end

  def to_param
    return permalink if permalink
    save
    permalink
  end
  
  private
    def create_permalink
      if self.nickname
        "#{id}-#{nickname.gsub(/[^a-z0-9]+/i, '-')}".downcase
      else
        "#{id}"
      end
        
    end

end
