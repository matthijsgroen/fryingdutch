module BoardsHelper
  
  def bread_crumbs(board)
    items = []
    items << link_to_unless_current(h(board.name), board)      
    while board = board.parent       
      items << link_to_unless_current(h(board.name), board)      
    end   
    items << link_to_unless_current("Alle fora", boards_path)
    items.reverse.join " &gt; "
  end
  
  def new_topic_path(board)
    topic = :discussion_topics
    
    send "new_board_#{topic.to_s.singularize}_path", board
  end

end
