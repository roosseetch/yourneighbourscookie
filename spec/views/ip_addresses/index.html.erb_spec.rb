require 'spec_helper'

describe "ip_addresses/index" do
  before(:each) do
    assign(:ip_addresses, [
      stub_model(IpAddress),
      stub_model(IpAddress)
    ])
  end

  it "renders a list of ip_addresses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
