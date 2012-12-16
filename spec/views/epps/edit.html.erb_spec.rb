require 'spec_helper'

describe "eps/edit" do
  before(:each) do
    @epp = assign(:epp, stub_model(Epp))
  end

  it "renders the edit epp form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => eps_path(@epp), :method => "post" do
    end
  end
end
