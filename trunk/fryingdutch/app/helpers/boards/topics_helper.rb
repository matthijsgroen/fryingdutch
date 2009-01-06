module Boards::TopicsHelper
  
  def board_boards_discussion_topic_url(board, topic)
    board_discussion_topic_url(board, topic)
  end

  def board_boards_discussion_topic_path(board, topic)
    board_discussion_topic_path(board, topic)
  end

  include BoardsHelper
  
  alias :board_bread_crumbs :bread_crumbs 
  
  def bread_crumbs(topic)
    items = []
    items << board_bread_crumbs(topic.comment_on)
    items << link_to_unless_current(h(topic.content.title), [topic.comment_on, topic.content])
    items.join " &gt; "
  end
    
  
end