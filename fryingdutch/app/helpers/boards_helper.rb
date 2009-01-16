module BoardsHelper
 
  def new_topic_path(board)
    topic = :discussion_topics
    
    send "new_board_#{topic.to_s.singularize}_path", board
  end

  include Boards::TopicsHelper

end
