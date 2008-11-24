require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GamesController do

  def mock_game(stubs={})
    @mock_game ||= mock_model(Game, stubs)
  end

  def mock_tag(stubs={})
    @mock_tag ||= mock_model(Tag, stubs)
  end
  
  it "should expose all games as @games" do
    Game.should_receive(:find).with(:all).and_return([mock_game])
    get :index
    assigns[:games].should == [mock_game]
  end

  it "should enable a tag-cloud as @tags" do
    Game.should_receive(:tag_counts).with(:order => "name asc").and_return([mock_tag])
    get :index
    assigns[:tags].should == [mock_tag]
  end
  
  describe "with mime type of xml" do
    
    it "should render all games as xml" do
      request.env["HTTP_ACCEPT"] = "application/xml"
      Game.should_receive(:find).with(:all).and_return(games = mock("Array of Games"))
      games.should_receive(:to_xml).and_return("generated XML")
      get :index
      response.body.should == "generated XML"
    end
    
  end


  describe "responding to GET show" do

    it "should expose the requested game as @game" do
      Game.should_receive(:find_by_permalink).with("37").and_return(mock_game)
      get :show, :id => "37"
      assigns[:game].should equal(mock_game)
    end
    
    describe "with mime type of xml" do

      it "should render the requested game as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Game.should_receive(:find_by_permalink).with("37").and_return(mock_game)
        mock_game.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end
      
    end
    
  end

  describe "with valid rights" do
    
    before(:each) do
      controller.stub!(:current_user).and_return(mock_model(User, { :id => 1 }))
    end

    describe "responding to GET new" do
      
      it "should expose a new game as @game" do
        Game.should_receive(:new).and_return(mock_game)
        get :new
        assigns[:game].should equal(mock_game)
      end
      
    end

    describe "responding to GET edit" do
      
      it "should expose the requested game as @game" do
        Game.should_receive(:find_by_permalink).with("37").and_return(mock_game)
        get :edit, :id => "37"
        assigns[:game].should equal(mock_game)
      end
      
    end
  
    describe "responding to POST create" do
      
      describe "with valid params" do
        
        it "should expose a newly created game as @game" do
          Game.should_receive(:new).with({'these' => 'params'}).and_return(mock_game(:save => true))
          post :create, :game => {:these => 'params'}
          assigns(:game).should equal(mock_game)
        end
        
        it "should redirect to the games list" do
          Game.stub!(:new).and_return(mock_game(:save => true))
          post :create, :game => {}
          response.should redirect_to(game_url(mock_game))
        end        
        
      end
      
      describe "with invalid params" do
        
        it "should expose a newly created but unsaved game as @game" do
          Game.stub!(:new).with({'these' => 'params'}).and_return(mock_game(:save => false))
          post :create, :game => {:these => 'params'}
          assigns(:game).should equal(mock_game)
        end  
        
        it "should re-render the 'new' template" do
          Game.stub!(:new).and_return(mock_game(:save => false))
          post :create, :game => {}
          response.should render_template('new')
        end   
        
      end   
      
    end
  
    describe "responding to PUT update" do
      
      describe "with valid params" do
        
        it "should update the requested game" do
          Game.should_receive(:find_by_permalink).with("37").and_return(mock_game)
          mock_game.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :game => {:these => 'params'}
        end
        
        it "should expose the requested game as @game" do
          Game.stub!(:find_by_permalink).and_return(mock_game(:update_attributes => true))
          put :update, :id => "1"
          assigns(:game).should equal(mock_game)
        end
        
        it "should redirect to the game" do
          Game.stub!(:find_by_permalink).and_return(mock_game(:update_attributes => true))
          put :update, :id => "1"
          response.should redirect_to(game_url(mock_game))
        end
        
      end
      
      describe "with invalid params" do
  
        it "should update the requested game" do
          Game.should_receive(:find_by_permalink).with("37").and_return(mock_game)
          mock_game.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :game => {:these => 'params'}
        end
  
        it "should expose the board as @board" do
          Game.stub!(:find_by_permalink).and_return(mock_game(:update_attributes => false))
          put :update, :id => "1"
          assigns(:game).should equal(mock_game)
        end
  
        it "should re-render the 'edit' template" do
          Game.stub!(:find_by_permalink).and_return(mock_game(:update_attributes => false))
          put :update, :id => "1"
          response.should render_template('edit')
        end
  
      end
  
    end
  
    describe "responding to DELETE destroy" do
  
      it "should destroy the requested game" do
        Game.should_receive(:find_by_permalink).with("37").and_return(mock_game)
        mock_game.should_receive(:destroy)
        delete :destroy, :id => "37"
      end
    
      it "should redirect to the games list" do
        Game.stub!(:find_by_permalink).and_return(mock_game(:destroy => true))
        delete :destroy, :id => "1"
        response.should redirect_to(games_url)
      end
  
    end

  end

  describe "with invalid rights" do
    
    before(:each) do
      controller.stub!(:current_user).and_return(nil)
    end

    describe "responding to GET new" do
      
      it "should show invalid login message" do
        Game.should_not_receive(:new).and_return(mock_game)
        get :new
        assigns[:game].should be_nil
        flash[:message].should == login_error
      end
      
    end

    describe "responding to GET edit" do
      
      it "should show invalid login message" do
        Game.should_not_receive(:find_by_permalink).with("37").and_return(mock_game)
        get :edit, :id => "37"
        assigns[:game].should be_nil
        flash[:message].should == login_error
      end
      
    end
  
    describe "responding to POST create" do
      
      it "should show invalid login message" do
        Game.should_not_receive(:new)
        post :create, :game => {:these => 'params'}
        assigns(:game).should be_nil
        flash[:message].should == login_error
      end
      
    end
  
    describe "responding to PUT update" do
      
      it "should show invalid login message" do
        Game.should_not_receive(:find_by_permalink)
        post :update, :game => {:these => 'params'}
        assigns(:game).should be_nil
        flash[:message].should == login_error
      end
  
    end
  
    describe "responding to DELETE destroy" do
  
      it "should show invalid login message" do
        Game.should_not_receive(:find_by_permalink)
        post :destroy, :id => "37"
        flash[:message].should == login_error
      end
  
    end

  end
  
end
