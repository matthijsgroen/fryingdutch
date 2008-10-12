class Game < ActiveRecord::Base

  validates_uniqueness_of :name
  validates_presence_of :description
  acts_as_taggable
  
  has_many :user_games, :dependent => :destroy
  has_many :users, :through => :user_games


  def before_save
    self.permalink = "#{name.gsub(/[^a-z0-9]+/i, '-')}".downcase if self.name
  end

  def to_param
    return permalink if permalink
    save
    permalink
  end

end
