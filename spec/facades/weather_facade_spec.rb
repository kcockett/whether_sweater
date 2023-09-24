require "rails_helper"

RSpec.describe "WeatherFacade", :vcr, type: :facade do
  describe "#current_weather" do

    before do
      location = "cincinatti,oh"
      facade = WeatherFacade.new(location)
      @weather_check = facade.weather
    end

    it "returns a location information as a hash of 'latitude, longitude' and no other info" do
      info = @weather_check.location
      expect(info).to be_a(Hash)
      expect(info[:lat]).to eq(39.11)
      expect(info[:lon]).to eq(-84.5)
      require 'pry'; binding.pry
    end
    
    it "the Weather object includes current weather information" do
      info = @weather_check.current
      expect(info[:last_updated]).to be_a(String)
      expect(info[:temp]).to be_a(Float)
      expect(info[:feels_like]).to be_a(Float)
      expect(info[:humidity]).to be_a(Integer)
      expect(info[:uvi]).to be_a(Float)
      expect(info[:visibility]).to be_a(Float)
      expect(info[:condition]).to be_a(String)
      expect(info[:icon]).to be_a(String)
    end
    
    it "the Weather object includes a 5-day weather forecast" do
      forecast_day = @weather_check.forecast.first
      expect(forecast_day[:date]).to be_a(String)
      expect(forecast_day[:sunrise]).to be_a(String)
      expect(forecast_day[:sunset]).to be_a(String)
      expect(forecast_day[:max_temp]).to be_a(Float)
      expect(forecast_day[:min_temp]).to be_a(Float)
      expect(forecast_day[:condition]).to be_a(String)
      expect(forecast_day[:icon]).to be_a(String)
    end
  
  end
end