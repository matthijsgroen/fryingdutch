class Game < ActiveRecord::Base

  validates_uniqueness_of :name
  validates_presence_of :description
  acts_as_taggable
  has_many :game_ratings, :dependent => :destroy
  has_one :game_metadata, :dependent => :destroy
  has_permalink
  
  has_many :user_games, :dependent => :destroy
  has_many :users, :through => :user_games
  has_many :comments, :as => :comment_on, :conditions => { :category => "comment" }, :order => "position, created_at DESC", :dependent => :destroy
  has_many :screenshots, :class_name => "Comment", :as => :comment_on, :conditions => { :category => "screenshot" }, :order => "position, created_at DESC", :dependent => :destroy
  has_many :usershots, :class_name => "Comment", :as => :comment_on, :conditions => { :category => "usershot" }, :order => "position, created_at DESC", :dependent => :destroy

  has_many :user_games_playing, :class_name => "UserGame", :conditions => "user_games.end_date IS NULL"
  has_many :players, :class_name => "User", :through => :user_games_playing, :source => :user

  def rating
    game_ratings.average :rating
  end

  def extra_support?
    support != GameSupport::GameSupportController
  end
  
  def support
    begin
      @support ||= "GameSupport::#{permalink.underscore.camelize}Controller".constantize
    rescue
      @support = GameSupport::GameSupportController
    end
  end

end
