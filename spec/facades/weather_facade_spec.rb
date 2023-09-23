require "rails_helper"

RSpec.describe "WeatherFacade", :vcr, type: :facade do
  describe "#current_weather" do

    before do
      location = "thornton,co"
      facade = WeatherFacade.new(location)
      @weather_check = facade.get_weather
    end

    it "returns a Weather object with location information" do
      info = @weather_check.location
      expect(@weather_check).to be_a(Weather)
      expect(info[:name]).to eq("Thornton")
      expect(info[:state]).to eq("Colorado")
      expect(info[:country]).to eq("United States of America")
      expect(info[:lat]).to eq(39.87)
      expect(info[:lon]).to eq(-104.97)
      expect(info[:time_zone]).to eq("America/Denver")
      expect(info[:localtime]).to be_a(String)
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