require "spec_helper"

describe IpAddressesController do
  describe "routing" do

    it "routes to #index" do
      get("/ip_addresses").should route_to("ip_addresses#index")
    end

    it "routes to #new" do
      get("/ip_addresses/new").should route_to("ip_addresses#new")
    end

    it "routes to #show" do
      get("/ip_addresses/1").should route_to("ip_addresses#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ip_addresses/1/edit").should route_to("ip_addresses#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ip_addresses").should route_to("ip_addresses#create")
    end

    it "routes to #update" do
      put("/ip_addresses/1").should route_to("ip_addresses#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ip_addresses/1").should route_to("ip_addresses#destroy", :id => "1")
    end

  end
end
