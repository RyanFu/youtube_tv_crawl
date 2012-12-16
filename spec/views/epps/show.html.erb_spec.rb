require 'spec_helper'

describe "eps/show" do
  before(:each) do
    @epp = assign(:epp, stub_model(Epp))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
