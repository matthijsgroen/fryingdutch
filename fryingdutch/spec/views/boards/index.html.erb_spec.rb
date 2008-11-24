require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/boards/index.html.erb" do
  include BoardsHelper
  
  before(:each) do
    assigns[:boards] = [
      stub_model(Board,
        :parent => nil,
        :name => "value for name",
        :description => "value for description",
        :position => "1"
      ),
      stub_model(Board,
        :parent => nil,
        :name => "value for name",
        :description => "value for description",
        :position => "2"
      )
    ]
  end

  it "should render list of boards" do
    render "/boards/index.html.erb"
    response.should have_tag("tr>td", "value for name", 2)
    response.should have_tag("tr>td", "value for description", 2)
    response.should have_tag("tr>td", "1", 1)
    response.should have_tag("tr>td", "2", 1)
  end
end

