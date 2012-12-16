require 'spec_helper'

describe "eps/index" do
  before(:each) do
    assign(:eps, [
      stub_model(Epp),
      stub_model(Epp)
    ])
  end

  it "renders a list of eps" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
