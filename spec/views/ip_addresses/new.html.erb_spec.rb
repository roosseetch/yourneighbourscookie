require 'spec_helper'

describe "ip_addresses/new" do
  before(:each) do
    assign(:ip_address, stub_model(IpAddress).as_new_record)
  end

  it "renders new ip_address form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", ip_addresses_path, "post" do
    end
  end
end
