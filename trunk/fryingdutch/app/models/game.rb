class Game < ActiveRecord::Base

  validates_uniqueness_of :name
  validates_presence_of :description
  validates_presence_of :name
  acts_as_taggable
  has_many :game_ratings
  has_one :game_metadata
  
  include GameExtension

  validates_each :name do |record, attr, value|
    record.errors.add attr, 'Een soortgelijke naam is al in gebruik!' if not record.new_record? and Game.find :first, :conditions => ["permalink LIKE ? AND id <> ?", record.get_permalink, record.id]
    record.errors.add attr, 'Een soortgelijke naam is al in gebruik!' if record.new_record? and Game.find :first, :conditions => ["permalink LIKE ?", record.get_permalink]
  end
  
  has_many :user_games, :dependent => :destroy
  has_many :users, :through => :user_games
  has_many :comments, :as => :comment_on, :conditions => { :category => "comment" }, :order => "position, created_at DESC"
  has_many :screenshots, :class_name => "Comment", :as => :comment_on, :conditions => { :category => "screenshot" }, :order => "position, created_at DESC"
  has_many :usershots, :class_name => "Comment", :as => :comment_on, :conditions => { :category => "usershot" }, :order => "position, created_at DESC"

  has_many :user_games_playing, :class_name => "UserGame", :conditions => "user_games.end_date IS NULL"
  has_many :players, :class_name => "User", :through => :user_games_playing, :source => :user


  def before_save
    self.permalink = get_permalink
  end
  
  def get_permalink
    "#{name.gsub(/[^a-z0-9]+/i, '-')}".downcase if self.name
  end

  def rating
    game_ratings.average :rating
  end

  def to_param
    return permalink if permalink
    save
    permalink
  end

end
