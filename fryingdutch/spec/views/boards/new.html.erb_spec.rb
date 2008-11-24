require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/boards/new.html.erb" do
  include BoardsHelper
  
  before(:each) do
    assigns[:board] = stub_model(Board,
      :new_record? => true,
      :parent => nil,
      :name => "value for name",
      :description => "value for description",
      :position => "1"
    )
  end

  it "should render new form" do
    render "/boards/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", boards_path) do
      with_tag("input#board_name[name=?]", "board[name]")
      with_tag("input#board_description[name=?]", "board[description]")
    end
  end
end


