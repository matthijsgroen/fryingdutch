class Comment < ActiveRecord::Base

  belongs_to :comment_on, :polymorphic => true
  belongs_to :content, :polymorphic => true, :dependent => :destroy
  belongs_to :user
  
  acts_as_list :scope => 'comment_on_id = #{comment_on_id} AND comment_on_type = \"#{comment_on_type}\" AND category = \"#{category}\"'
  
  def read_item(category, user, item)
    return unless user
    read = ReadContent.find_or_create_by_item_id_and_item_type_and_user_id_and_category(self.content_id, self.content_type, user.id, category)
    read.updated_at = item.updated_at if item and item.updated_at < read.updated_at 
    read.save
  end

  def unread_items?(category, user)
    return false unless user    
    read = ReadContent.find_by_item_id_and_item_type_and_user_id_and_category(self.content_id, self.content_type, user.id, category)
    return true unless read    
    reaction = Comment.find :first, 
      :conditions => { 
        :comment_on_id => self.content_id, 
        :comment_on_type => self.content_type,
        :category => category
      },
      :order => "updated_at DESC"
    return reaction.updated_at > read.updated_at if reaction
    return self.updated_at > read.updated_at
  end

  def method_missing(method_id, *arguments)
    if match = /^read_([_a-zA-Z]\w*)$/.match(method_id.to_s)
      read_item(match[1], *arguments)
    elsif match = /^unread_([_a-zA-Z]\w*)\_for$/.match(method_id.to_s)
      unread_items?(match[1].singularize, *arguments)
    else
      super
    end
  end
  
  def respond_to?(method_id)
    return true if /^read_([_a-zA-Z]\w*)$/.match(method_id.to_s)
    return true if /^has_unread_([_a-zA-Z]\w*)_for$/.match(method_id.to_s)
    super
  end

end
