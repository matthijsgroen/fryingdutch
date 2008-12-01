module BoardsHelper
  
  def bread_crumbs(board)
    items = []
    while board = board.parent       
      items << link_to(h(board.name), board)      
    end   
    items << link_to("alle boards", boards_path)
    items.reverse.join " \\ "
  end

end
