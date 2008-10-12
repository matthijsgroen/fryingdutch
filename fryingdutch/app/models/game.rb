class Game < ActiveRecord::Base

  validates_uniqueness_of :name
  validates_presence_of :description
  acts_as_taggable
  
  validates_each :name do |record, attr, value|
    record.errors.add attr, 'Een soortgelijke naam is al in gebruik!' if Game.find_by_permalink(record.get_permalink)
  end
  
  has_many :user_games, :dependent => :destroy
  has_many :users, :through => :user_games


  def before_save
    self.permalink = get_permalink
  end
  
  def get_permalink
    "#{name.gsub(/[^a-z0-9]+/i, '-')}".downcase if self.name
  end

  def to_param
    return permalink if permalink
    save
    permalink
  end

end
