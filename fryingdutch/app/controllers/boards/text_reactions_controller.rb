class Boards::TextReactionsController < ApplicationController

  before_filter :get_board
  before_filter :get_topic

  def new
    @text_reaction = TextComment.new
  end
  
  def create
    
  end

  private
    def get_board
      @board = Board.find_by_permalink params[:board_id]
    end
  
    def get_topic
      @topic = @board.topics.find params[:topic_id]
    end

end
