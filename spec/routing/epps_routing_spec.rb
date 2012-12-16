require "spec_helper"

describe EppsController do
  describe "routing" do

    it "routes to #index" do
      get("/eps").should route_to("eps#index")
    end

    it "routes to #new" do
      get("/eps/new").should route_to("eps#new")
    end

    it "routes to #show" do
      get("/eps/1").should route_to("eps#show", :id => "1")
    end

    it "routes to #edit" do
      get("/eps/1/edit").should route_to("eps#edit", :id => "1")
    end

    it "routes to #create" do
      post("/eps").should route_to("eps#create")
    end

    it "routes to #update" do
      put("/eps/1").should route_to("eps#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/eps/1").should route_to("eps#destroy", :id => "1")
    end

  end
end
