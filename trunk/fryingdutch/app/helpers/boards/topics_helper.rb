module Boards::TopicsHelper
  
  def board_boards_discussion_topic_url(board, topic)
    board_discussion_topic_url(board, topic)
  end

  def board_boards_discussion_topic_path(board, topic)
    board_discussion_topic_path(board, topic)
  end
   
  def bread_crumbs_for(*parts)
    items = []
    parts = [parts] unless parts.class == Array 
    
    board, topic, reaction = parts[0], parts[1], parts[2] if parts.size == 3 
    board, topic = parts[0], parts[1] if parts.size == 2 
    board = parts[0] if parts.size == 1 
    
    if reaction
      items << "Reactie toevoegen" if reaction.new_record?
      items << "Reactie bewerken" unless reaction.new_record?
    end
    
    if topic
      items << link_to_unless_current(h(topic.content.title), [topic.comment_on, topic.content])
    end

    if board
      items << link_to_unless_current(h(board.name), board)      
      while board = board.parent       
        items << link_to_unless_current(h(board.name), board)      
      end  
    end
    
    items << link_to_unless_current("Alle fora", boards_path)
    items.reverse.join " &gt; "
  end
   
end