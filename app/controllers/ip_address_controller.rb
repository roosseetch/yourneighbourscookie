class IpAddressController < ApplicationController
  def import
    if request.post? && params[:file].present?
      IpAddress.import!(:file)

  def index
   stored_data = IpAddress.all
  end
end
