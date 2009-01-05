class Board < ActiveRecord::Base
  
  belongs_to :parent, :class_name => "Board"
  has_many :children, :foreign_key => "parent_id", :class_name => "Board", :order => "position"
  
  has_many :topics, :class_name => "Comment", :as => :comment_on, :conditions => { :category => "topic" }, :order => "updated_at DESC", :dependent => :destroy
  
  has_permalink
  acts_as_list :scope => 'parent_id #{parent_id.nil? ? " IS NULL" : " = #{parent_id}"}'
  named_scope :root_boards, :conditions => { :parent_id => nil }, :order => "position"

end