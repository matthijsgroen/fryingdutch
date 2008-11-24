require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/boards/show.html.erb" do
  include BoardsHelper
  
  before(:each) do
    assigns[:board] = @board = stub_model(Board,
      :parent => nil,
      :name => "value for name",
      :description => "value for description",
      :position => "1"
    )
  end

  it "should render attributes in <p>" do
    render "/boards/show.html.erb"
    response.should have_text(//)
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ description/)
    response.should have_text(/1/)
  end
end

