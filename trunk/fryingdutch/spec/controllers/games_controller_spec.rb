require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'ostruct'

describe GamesController, "overview page" do
  before(:each) do
    # Generally, prefer stub! over should_receive in setup.
    @game = mock_model(Game)
    Game.stub!(:new).and_return(@game)
    @tag = mock_model(Tag)
    Tag.stub!(:new).and_return(@tag)
  end
  
  it "should expose all games" do
    Game.should_receive(:find).with(:all).and_return([@game])
    get :index
    assigns[:games].should == [@game]
    response.should be_success
  end

  it "should enable a tag-cloud" do
    Game.should_receive(:tag_counts).with(:order => "name asc").and_return([@tag])
    get :index
    assigns[:tags].should == [@tag]
    response.should be_success
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
end
