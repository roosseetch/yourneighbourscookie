require 'spec_helper'

describe "ip_addresses/show" do
  before(:each) do
    @ip_address = assign(:ip_address, stub_model(IpAddress))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
