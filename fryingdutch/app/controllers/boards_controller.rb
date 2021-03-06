class BoardsController < ApplicationController

  before_filter :login_required, :only => [:new, :add_board, :create, :edit, :update, :destroy]

  # GET /boards
  # GET /boards.xml
  def index
    @boards = Board.root_boards

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @boards }
    end
  end

  # GET /boards/1
  # GET /boards/1.xml
  def show
    @board = Board.find_by_permalink(params[:id])
    @topics = @board.topics

    respond_to do |format|
      format.html # show.html.erb
      format.js {
        render :update do |page|
          page[@board].replace_html :partial => "board_info", :object => @board
        end      
      }
      format.xml  { render :xml => @board }
    end
  end

  # GET /boards/new
  # GET /boards/new.xml
  def new
    @board = Board.new

    respond_to do |format|
      format.html # new.html.erb
      format.js { render_to_facebox }
      format.xml  { render :xml => @board }
    end
  end

  def add_board
    @parent = Board.find_by_permalink params[:board_id]
    @board = Board.new :parent_id => @parent.id
    respond_to do |format|
      format.html { render :action => "new" }
      format.xml  { render :xml => @board }
    end
  end

  # GET /boards/1/edit
  def edit
    @board = Board.find_by_permalink(params[:id])
    
    respond_to do |format|
      format.html # edit.html.erb
      format.js {
        render :update do |page|
          page[@board].replace_html :partial => "remote_edit"
        end      
      }
    end
  end

  # POST /boards
  # POST /boards.xml
  def create
    @board = Board.new(params[:board])

    respond_to do |format|
      if @board.save
        flash[:notice] = 'Board was successfully created.'
        format.html { redirect_to(@board) }
        format.xml  { render :xml => @board, :status => :created, :location => @board }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @board.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /boards/1
  # PUT /boards/1.xml
  def update
    @board = Board.find_by_permalink(params[:id])

    respond_to do |format|
      if @board.update_attributes(params[:board])
        flash[:notice] = 'Board was successfully updated.'
        format.html { redirect_to(@board) }
        format.js {
          render :update do |page|
            page[@board].replace_html :partial => "board_info", :object => @board
            page[@board].highlight 1000
          end
        }        
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @board.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.xml
  def destroy
    @board = Board.find_by_permalink(params[:id])
    @board.destroy

    respond_to do |format|
      format.html { redirect_to(boards_url) }
      format.xml  { head :ok }
    end
  end
end
