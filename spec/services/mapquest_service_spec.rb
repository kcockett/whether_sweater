require "rails_helper"

RSpec.describe "Mapquest Service", type: :service do
  describe "Retrieves location information from http://wwwmapquestapi.com", :vcr do

    describe "#initialize" do
      it "can initialize with a location" do
        address = "13495 Holly St, Thornton, CO 80602"
        service = MapquestService.new(address)
        latitude = service.location[:results].first[:locations].first[:latLng][:lat]
        longitude = service.location[:results].first[:locations].first[:latLng][:lng]
        expect(service).to be_a MapquestService
        expect(latitude).to be_a Float
        expect(longitude).to be_a Float
      end
    end

    describe "#get_location_information" do
    
      it "can return latitude and longitude for a given address" do
        address = "13495 Holly St, Thornton, CO 80602"
        service = MapquestService.new(address)
        location = service.location
        
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

    describe "#get_route" do

      it "can return route information" do
        origin = "13495 Holly St, Thornton, CO 80602"
        destination = "2300 Steele St, Denver, CO 80205"
        service = MapquestService.new(origin)
        travel_params = {origin: origin, destination: destination }
        route = service.get_route(travel_params)

        expect(route).to be_a Hash
        expect(route).to have_key(:route)
        expect(route[:route]).to be_a Hash

        expect(route[:route]).to have_key(:time)
        expect(route[:route][:time]).to be_a Integer
        
        expect(route[:route]).to have_key(:formattedTime)
        expect(route[:route][:formattedTime]).to be_a String
      end
    end
  end
end