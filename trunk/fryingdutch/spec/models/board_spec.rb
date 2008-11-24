require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Board do
  before(:each) do
    @valid_attributes = {
      :parent => nil,
      :name => "value for name",
      :description => "value for description",
      :position => "1"
    }
  end

  it "should create a new instance given valid attributes" do
    Board.create!(@valid_attributes)
  end
end
