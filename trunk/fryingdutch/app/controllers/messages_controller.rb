class MessagesController < ApplicationController
  
  before_filter :login_required
  
  def index
    
    respond_to do |format|
      format.html # index.html.erb
      format.facebox { render_to_facebox }
    end    
  end

  def show
  end

  def new
    @message = Messages::MessageHeader.new
    @message.content = TextComment.new 
    
    respond_to do |format|
      format.html #new.html.erb
      format.facebox { render_to_facebox }
      format.js {
        render :update do |page|
          page["#facebox h1"].replace_html :text => "Berichten - Nieuw bericht"
          page["#messagemain"].replace_html :partial => "remote_compose"
        end
      }
    end
  end

  def edit
  end

end
