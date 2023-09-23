require "rails_helper"

RSpec.describe "Weather", :vcr, type: :poro do
  describe "#initialize" do
    it "should initialize" do
      location = {name: "Thornton", region: "Colorado", country: "United States of America", lat: 39.87, lon: -104.97, time_zone: "America/Denver", localtime: "2023-09-22 19:15"}
      current_weather = {last_updated: "2023-09-22 18:00", temp: 71.6, feels_like: 73.0, humidity: 20, uv: 1.0, vis_miles: 9.0, condition: {text: "Partly cloudy", icon: "//cdn.weatherapi.com/weather/64x64/night/116.png"}}


      expect(weather_check.location[:name]).to eq("Thornton")
      expect(weather_check.location[:region]).to eq("Colorado")
      expect(weather_check.location[:country]).to eq("United States of America")
      expect(weather_check.location[:lat]).to eq(39.87)
      expect(weather_check.location[:lon]).to eq(-104.97)
      expect(weather_check.location[:time_zone]).to eq("America/Denver")
      expect(weather_check.location[:localtime]).to eq("2023-09-22 19:15")

      expect(weather_check.current[:last_updated]).to eq("2023-09-22 18:00")
      expect(weather_check.current[:temp]).to eq(71.6)
      expect(weather_check.current[:feels_like]).to eq(73.0)
      expect(weather_check.current[:humidity]).to eq(20)
      expect(weather_check.current[:uv]).to eq(1.0)
      expect(weather_check.current[:vis_miles]).to eq(9.0)
      expect(weather_check.current[:condition][:text]).to eq("Partly cloudy")
      expect(weather_check.current[:condition][:icon]).to eq("//cdn.weatherapi.com/weather/64x64/night/116.png")
    end
  end
end