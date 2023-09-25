require "rails_helper"

RSpec.describe "RoadtripFacade", :vcr, type: :facade do
  describe "returns Roadtrip object with necessary attributes" do

    before do
      user = User.create!(email: "user@example.com", password: "password")
      origin = "Cincinatti,OH"
      destination = "Chicago,IL"
      api_key = user.api_key
      params = {origin: origin, destination: destination, api_key: api_key}
      @roadtrip = RoadtripFacade.new(params)
    end

    it "returns a Roadtrip object" do
      expect(@roadtrip).to be_a Roadtrip
    end

    it "Roadtrip object has attributes start_city as a string" do
      expect(@roadtrip.start_city).to be_a String
    end
    
    it "Roadtrip object has attributes end_city as a string" do
      expect(@roadtrip.end_city).to be_a String
    end
    
    it "Roadtrip object has attributes travel_time as a string in user-friendly format" do
      expect(@roadtrip.travel_time).to be_a String
    end
    
    it "Roadtrip object has attributes weather_at_eta as a hash" do
      expect(@roadtrip.weather_at_eta).to be_a Hash
    end
    
    it "Weather_at_eta contains ':datetime' String which is the expected arrival date and time" do
      expect(@roadtrip.weather_at_eta).to have_key(:datetime)
      expect(@roadtrip.weather_at_eta[:datetime]).to be_a String

      expect(@roadtrip.weather_at_eta).to have_key(:temperature)
      expect(@roadtrip.weather_at_eta[:temperature]).to be_a Float
      
      expect(@roadtrip.weather_at_eta).to have_key(:condition)
      expect(@roadtrip.weather_at_eta[:condition]).to be_a String
    end
  end
end