class Boards::DiscussionTopic < ActiveRecord::Base
  
  validates_length_of :title, :minimum => 2, :too_short => "moet uit minimaal %d woorden bestaan.", :tokenizer => lambda {|str| str.scan(/\w+/) }
  validates_length_of :body, :minimum => 5, :too_short => "moet uit minimaal %d woorden bestaan.", :tokenizer => lambda {|str| str.scan(/\w+/) }

end
