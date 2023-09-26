require "rails_helper"

RSpec.describe Roadtrip, type: :poro do
  describe "#initialize", :vcr do
    before do
      user = User.create!(email: "user@example.com", password: "password")
      @origin = "Cincinatti,OH"
      @destination = "Chicago,IL"
      @travel_time_formatted = "04:21:15"
      @weather_at_eta = {
        datetime: "2023-09-25 23:30",
        temperature: 66.0,
        condition: "Cloudy"
      }

      params = {
        start_city: @origin,
        end_city: @destination, 
        travel_time: @travel_time_formatted, 
        weather_at_eta: @weather_at_eta
      }
      @roadtrip = Roadtrip.new(params)
    end

    it "should initialize with expected attributes" do
      expect(@roadtrip).to be_a Roadtrip
      expect(@roadtrip.start_city).to eq(@origin)
      expect(@roadtrip.end_city).to eq(@destination)
      expect(@roadtrip.travel_time).to eq(@travel_time_formatted)

      expect(@roadtrip.weather_at_eta).to be_a Hash
      expect(@roadtrip.weather_at_eta).to have_key(:datetime)
      expect(@roadtrip.weather_at_eta[:datetime]).to eq(@weather_at_eta[:datetime])

      expect(@roadtrip.weather_at_eta).to have_key(:temperature)
      expect(@roadtrip.weather_at_eta[:temperature]).to eq(@weather_at_eta[:temperature])

      expect(@roadtrip.weather_at_eta).to have_key(:condition)
      expect(@roadtrip.weather_at_eta[:condition]).to eq(@weather_at_eta[:condition])
    end
  end
end