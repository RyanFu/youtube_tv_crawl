require 'spec_helper'

describe "eps/new" do
  before(:each) do
    assign(:epp, stub_model(Epp).as_new_record)
  end

  it "renders new epp form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => eps_path, :method => "post" do
    end
  end
end
