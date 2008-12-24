class Boards::TextReactionsController < ApplicationController

  before_filter :get_board
  before_filter :get_topic

  def new
    @text_reaction = TextComment.new
  end
  
  def create
    @text_reaction = TextComment.new params[:text_comment]
    success = true
    if @text_reaction.save
      comment = Comment.new
      comment.comment_on = @topic.content
      comment.content = @text_reaction
      comment.category = "reaction"
      comment.user = current_user
      unless comment.save
        @text_reaction.destroy
        success = false
      end
      @topic.updated_at = Time.now
      @topic.save
    else
      success = false
    end
    
    respond_to do |format|
      format.html {
        redirect_to [@board, @topic.content]
      }
    end
  end

  private
    def get_board
      @board = Board.find_by_permalink params[:board_id]
    end
  
    def get_topic
      @topic = @board.topics.find params[:topic_id]
    end

    include TopicsHelper
end
