class GameCommentsController < ApplicationController
  
  before_filter :get_game

  def index
    @comments = @game.comments
    @text_comment = TextComment.new    
    respond_to do |format|
      format.js { render :partial => "index" } # _index.js.erb
    end
  end
  
  def create
    @text_comment = TextComment.new params[:text_comment]
    success = true
    if @text_comment.save
      comment = Comment.new
      comment.comment_on = @game
      comment.content = @text_comment
      comment.user = current_user
      unless comment.save
        @text_comment.destroy
        success = false
      end
    else
      success = false
    end
    
    @comments = @game.comments
    @text_comment = TextComment.new
    respond_to do |format|
      format.js {
        render :update do |page|
          page["##{dom_id(@game)} .tab_contents"].replace_html :partial => "index"
          page["##{dom_id(@game)} .game_menu a.comments"].replace_html "Speler commentaar (#{@game.comments.count})"
          page["##{dom_id(@game)} .game_menu a.comments"].highlight
          page["##{dom_id(comment)}"].highlight
        end
      }
    end
  end
  
  private
    def get_game
      @game = Game.find_by_permalink(params[:game_id])
    end

end
