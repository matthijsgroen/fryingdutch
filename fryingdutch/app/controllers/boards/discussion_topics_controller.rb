class Boards::DiscussionTopicsController < ApplicationController

  before_filter :login_required, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :get_board

  # GET /boards/discussion_topics/1
  # GET /boards/discussion_topics/1.xml
  def show
    @topic = @board.topics.find_by_content_id(params[:id])
    
    last_reaction = @topic.content.replies.find :last
    @topic.read_reaction @current_user, last_reaction

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /boards/discussion_topics/new
  # GET /boards/discussion_topics/new.xml
  def new
    @topic = @board.topics.new
    @topic.content = Boards::DiscussionTopic.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /boards/discussion_topics/1/edit
  def edit
    @discussion_topic = Boards::DiscussionTopic.find_by_content_id(params[:id])
  end

  # POST /boards/discussion_topics
  # POST /boards/discussion_topics.xml
  def create
    @topic = @board.topics.new

    @topic.content = Boards::DiscussionTopic.new(params[:boards_discussion_topic])
    respond_to do |format|
      if @topic.content.save
         flash[:notice] = 'Nieuwe discussie was succesvol gestart'
        @topic.user = current_user
        @topic.category = "topic"
        @topic.save
        
        format.html { redirect_to(board_discussion_topic_path(@board, @topic.content)) }
        format.xml  { render :xml => @topic, :status => :created, :location => board_discussion_topic_path(@board, @topic.content) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topic.content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /boards/discussion_topics/1
  # PUT /boards/discussion_topics/1.xml
  def update
    @discussion_topic = Boards::Topics::DiscussionTopic.find(params[:id])

    respond_to do |format|
      if @discussion_topic.update_attributes(params[:discussion_topic])
        flash[:notice] = 'Boards::Topics::DiscussionTopic was successfully updated.'
        format.html { redirect_to(@discussion_topic) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @discussion_topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/discussion_topics/1
  # DELETE /boards/discussion_topics/1.xml
  def destroy
    @discussion_topic = Boards::Topics::DiscussionTopic.find(params[:id])
    @discussion_topic.destroy

    respond_to do |format|
      format.html { redirect_to(boards/topics_discussion_topics_url) }
      format.xml  { head :ok }
    end
  end
  
  private

    def get_board
      @board = Board.find_by_permalink params[:board_id]  
    end
  
end
