require "rails_helper"

RSpec.describe "Weather Service", type: :service do
  describe "Retrieves weather information from http://api.weatherapi.com/v1/", :vcr do
    
    it "can retrieve current weather information" do
      
      location = "thornton,co"
      service = WeatherService.new(location)
      current_weather = service.get_current_weather

      expect(current_weather[:location][:name]).to be_a(String)
      expect(current_weather[:location][:name]).to eq("Thornton")
      
      expect(current_weather[:location][:region]).to be_a(String)
      expect(current_weather[:location][:region]).to eq("Colorado")

      expect(current_weather[:location][:country]).to be_a(String)
      expect(current_weather[:location][:country]).to eq("United States of America")
      
      expect(current_weather[:location][:lat]).to be_a(Float)
      expect(current_weather[:location][:lat]).to eq(39.87)
      
      expect(current_weather[:location][:lon]).to be_a(Float)
      expect(current_weather[:location][:lon]).to eq(-104.97)
      
      expect(current_weather[:location][:tz_id]).to be_a(String)
      expect(current_weather[:location][:tz_id]).to eq("America/Denver")
      
      expect(current_weather[:location][:localtime_epoch]).to be_a(Integer)
      expect(current_weather[:location][:localtime]).to be_a(String)
      
      expect(current_weather[:current][:last_updated_epoch]).to be_a(Integer)
      expect(current_weather[:current][:last_updated]).to be_a(String)
      expect(current_weather[:current][:temp_c]).to be_a(Float)
      expect(current_weather[:current][:temp_f]).to be_a(Float)
      expect(current_weather[:current][:is_day]).to be_a(Integer)
      expect(current_weather[:current][:condition][:text]).to be_a(String)
      expect(current_weather[:current][:condition][:icon]).to be_a(String)
      expect(current_weather[:current][:condition][:code]).to be_a(Integer)
      
      expect(current_weather[:current][:wind_mph]).to be_a(Float)
      expect(current_weather[:current][:wind_kph]).to be_a(Float)
      expect(current_weather[:current][:wind_degree]).to be_a(Integer)
      expect(current_weather[:current][:wind_dir]).to be_a(String)
      expect(current_weather[:current][:pressure_mb]).to be_a(Float)
      expect(current_weather[:current][:pressure_in]).to be_a(Float)
      expect(current_weather[:current][:humidity]).to be_a(Integer)
      expect(current_weather[:current][:cloud]).to be_a(Integer)
      expect(current_weather[:current][:feelslike_c]).to be_a(Float)
      expect(current_weather[:current][:feelslike_f]).to be_a(Float)
      expect(current_weather[:current][:vis_km]).to be_a(Float)
      expect(current_weather[:current][:vis_miles]).to be_a(Float)
      expect(current_weather[:current][:uv]).to be_a(Float)
      expect(current_weather[:current][:gust_mph]).to be_a(Float)
      expect(current_weather[:current][:gust_kph]).to be_a(Float)
    end
  end
end