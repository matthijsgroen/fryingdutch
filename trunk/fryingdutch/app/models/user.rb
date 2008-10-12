class User < ActiveRecord::Base

  has_many :user_games, :dependent => :destroy
  has_many :games, :through => :user_games

  def before_save
    self.permalink = "#{nickname.gsub(/[^a-z0-9]+/i, '-')}".downcase if self.nickname
  end

  def to_param
    return permalink if permalink
    save
    permalink
  end

end
