class MessagesController < ApplicationController
  
  before_filter :login_required
  
  def index
    
    respond_to do |format|
      format.html # index.html.erb
      format.js { render_to_facebox }
    end    
  end

  def show
  end

  def new
  end

  def edit
  end

end
