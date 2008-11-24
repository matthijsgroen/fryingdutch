require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/boards/edit.html.erb" do
  include BoardsHelper
  
  before(:each) do
    assigns[:board] = @board = stub_model(Board,
      :new_record? => false,
      :parent => nil,
      :name => "value for name",
      :description => "value for description",
      :position => "1"
    )
  end

  it "should render edit form" do
    render "/boards/edit.html.erb"
    
    response.should have_tag("form[action=#{board_path(@board)}][method=post]") do
      with_tag('input#board_name[name=?]', "board[name]")
      with_tag('input#board_description[name=?]', "board[description]")
    end
  end
end


