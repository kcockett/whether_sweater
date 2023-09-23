require "rails_helper"

RSpec.describe "Weather", :vcr, type: :poro do
  describe "#initialize" do
    describe "should initialize" do
      it "should initialze with current weather information" do
        location = {name: "Thornton", region: "Colorado", country: "United States of America", lat: 39.87, lon: -104.97, time_zone: "America/Denver", localtime: "2023-09-22 19:15"}
        
        current_weather = {last_updated: "2023-09-22 18:00", temp: 71.6, feels_like: 73.0, humidity: 20, uv: 1.0, vis_miles: 9.0, condition: {text: "Partly cloudy", icon: "//cdn.weatherapi.com/weather/64x64/night/116.png"}}

        params = {location: location, current: current_weather}

        object = Weather.new(params)

        expect(object.location[:name]).to eq("Thornton")
        expect(object.location[:region]).to eq("Colorado")
        expect(object.location[:country]).to eq("United States of America")
        expect(object.location[:lat]).to eq(39.87)
        expect(object.location[:lon]).to eq(-104.97)
        expect(object.location[:time_zone]).to eq("America/Denver")
        expect(object.location[:localtime]).to eq("2023-09-22 19:15")

        expect(object.current[:last_updated]).to eq("2023-09-22 18:00")
        expect(object.current[:temp]).to eq(71.6)
        expect(object.current[:feels_like]).to eq(73.0)
        expect(object.current[:humidity]).to eq(20)
        expect(object.current[:uv]).to eq(1.0)
        expect(object.current[:vis_miles]).to eq(9.0)
        expect(object.current[:condition][:text]).to eq("Partly cloudy")
        expect(object.current[:condition][:icon]).to eq("//cdn.weatherapi.com/weather/64x64/night/116.png")
      end
    end
  end
end