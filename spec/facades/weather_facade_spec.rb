require "rails_helper"

RSpec.describe "WeatherFacade", :vcr, type: :facade do
  describe "#current_weather" do

    before do
      location = "thornton,co"
      @facade = WeatherFacade.new(location)
    end

    it "returns the current weather in a Weather object" do
      weather_check = @facade.current_weather

      expect(weather_check).to be_a(Weather)
      expect(weather_check.location[:name]).to eq("Thornton")
      expect(weather_check.location[:state]).to eq("Colorado")
      expect(weather_check.location[:country]).to eq("United States of America")
      expect(weather_check.location[:lat]).to eq(39.87)
      expect(weather_check.location[:lon]).to eq(-104.97)
      expect(weather_check.location[:time_zone]).to eq("America/Denver")
      expect(weather_check.location[:localtime]).to be_a(String)
      
      expect(weather_check.current[:last_updated]).to be_a(String)
      expect(weather_check.current[:temp]).to be_a(Float)
      expect(weather_check.current[:feels_like]).to be_a(Float)
      expect(weather_check.current[:humidity]).to be_a(Integer)
      expect(weather_check.current[:uvi]).to be_a(Float)
      expect(weather_check.current[:visibility]).to be_a(Float)
      expect(weather_check.current[:condition]).to be_a(String)
      expect(weather_check.current[:icon]).to be_a(String)
    end
  end
end