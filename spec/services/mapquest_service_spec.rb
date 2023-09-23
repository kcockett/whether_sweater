require "rails_helper"

RSpec.describe "Mapquest Service", type: :service do
  describe "Retrieves location information from http://wwwmapquestapi.com/geocoding/v1/address", :vcr do

    before do
      address = "13495 Holly St, Thornton, CO 80602"
      service = MapquestService.new(address)
      @location = service.get_lat_lon
    end

    it "can return latitude and longitude for a given address" do
      expect(@location).to eq("39.93481, -104.92211")
    end
  end
end