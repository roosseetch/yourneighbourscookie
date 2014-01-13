require 'spec_helper'

describe "ip_addresses/edit" do
  before(:each) do
    @ip_address = assign(:ip_address, stub_model(IpAddress))
  end

  it "renders the edit ip_address form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", ip_address_path(@ip_address), "post" do
    end
  end
end
