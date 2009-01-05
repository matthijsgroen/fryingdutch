class Board < ActiveRecord::Base
  
  belongs_to :parent, :class_name => "Board"
  has_many :children, :foreign_key => "parent_id", :class_name => "Board", :order => "position"
  
  has_many :topics, :class_name => "Comment", :as => :comment_on, :conditions => { :category => "topic" }, :order => "updated_at DESC", :dependent => :destroy

  def unread_topics_for(user)
    topics.count \
      :conditions => ["comments.category = ? AND comments.updated_at > ? AND r.item_id IS NULL", "topic", 4.weeks.ago],
      :joins => "LEFT OUTER JOIN read_contents AS r ON (r.item_id = comments.content_id AND r.item_type = comments.content_type AND r.user_id = #{user.id})"
  end
  
  def unread_reactions_for(user)
    Comment.count \
      :joins => 
        "RIGHT OUTER JOIN comments AS t ON (comments.comment_on_id = t.content_id AND comments.comment_on_type = t.content_type) \
        RIGHT OUTER JOIN read_contents AS r ON (r.item_id = t.content_id AND r.item_type = t.content_type)",

      :conditions => [
        "t.comment_on_id = ? AND t.comment_on_type = ? AND r.updated_at < comments.updated_at", 
        self.id, "Board"]
      
#
# SELECT COUNT(`comments`.id) as unread FROM `comments` 
# RIGHT OUTER JOIN `comments` AS t ON comments.comment_on_id = t.content_id AND comments.comment_on_type = t.content_type
# RIGHT OUTER JOIN `read_contents` AS r ON r.item_id = t.content_id AND r.item_type = t.content_type
# WHERE 
#  
  end

  
  has_permalink
  acts_as_list :scope => 'parent_id #{parent_id.nil? ? " IS NULL" : " = #{parent_id}"}'
  named_scope :root_boards, :conditions => { :parent_id => nil }, :order => "position"

end
