module BoardsHelper
  
  def bread_crumbs(board)
    items = []
    while board = board.parent       
      items << link_to(h(board.name), board)      
    end   
    items << link_to("Alle fora", boards_path)
    items.reverse.join " \\ "
  end
  
  def new_topic_path(board)
    topic = :discussion_topics
    
    send "new_board_#{topic.to_s.singularize}_path", board
  end

end
