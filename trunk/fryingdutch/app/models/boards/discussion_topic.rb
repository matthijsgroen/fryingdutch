class Boards::DiscussionTopic < ActiveRecord::Base
  
  validates_length_of :title, :minimum => 2, :too_short => "moet uit minimaal %d woorden bestaan.", :tokenizer => lambda {|str| str.scan(/\w+/) }
  validates_length_of :body, :minimum => 4, :too_short => "moet uit minimaal %d woorden bestaan.", :tokenizer => lambda {|str| str.scan(/\w+/) }

  has_many :replies, :class_name => "Comment", :as => :comment_on, :conditions => { :category => "reaction" }, :order => "position, created_at DESC", :dependent => :destroy
  has_one :wrapper, :class_name => "Comment", :as => :content

end
