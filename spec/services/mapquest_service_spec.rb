require "rails_helper"

RSpec.describe "Mapquest Service", type: :service do
  describe "Retrieves location information from http://wwwmapquestapi.com/geocoding/v1/address", :vcr do

    before do
      address = "13495 Holly St, Thornton, CO 80602"
      @service = MapquestService.new(address)
    end

    it "can return latitude and longitude for a given address" do
      location = @service.location
      expect(location).to be_a Hash
      expect(location[:info]).to be_a Hash
      expect(location[:options]).to be_a Hash
      expect(location[:results]).to be_a Array
      expect(location[:results].first).to be_a Hash
      expect(location[:results].first[:locations]).to be_a Array
      expect(location[:results].first[:locations].first).to be_a Hash
      expect(location[:results].first[:locations].first[:latLng]).to be_a Hash
      expect(location[:results].first[:locations].first[:latLng][:lat]).to be_a Float
      expect(location[:results].first[:locations].first[:latLng][:lng]).to be_a Float
    end
  end
end