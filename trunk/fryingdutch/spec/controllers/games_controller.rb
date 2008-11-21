require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GamesController do

  def mock_game(stubs={})
    @mock_games ||= mock_model(Game, stubs)
  end
  
  describe "show a list of games" do
    controller_name :games
    
    it "should expose all games as @games" do
      Game.should_receive(:find).with(:all).and_return([mock_game])
      get :index
      assigns[:games].should == [mock_game]
    end

#    describe "with mime type of xml" do
#  
#      it "should render all posts as xml" do
#        request.env["HTTP_ACCEPT"] = "application/xml"
#        Post.should_receive(:find).with(:all).and_return(posts = mock("Array of Posts"))
#        posts.should_receive(:to_xml).and_return("generated XML")
#        get :index
#        response.body.should == "generated XML"
#      end
#    
#    end
  end
end
