class User < ActiveRecord::Base

  SYSTEM = 0; # UserID of the system User.

  has_many :user_games, :dependent => :destroy
  has_many :game_ratings
  has_many :user_games_playing, :class_name => "UserGame", :conditions => "user_games.end_date IS NULL"
  has_many :games_playing, :class_name => "Game", :through => :user_games_playing, :source => :game

  #validates_uniqueness_of :nickname, :allow_nil => true

  def before_save
    self.permalink = create_permalink 
  end
  
  def after_create
    self.permalink = create_permalink
    save
  end
  
  def plays(game)
    self.user_games.create :start_date => Date.today, :game => game, :user => self
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
