require "rails_helper"

RSpec.describe "Weather Service", type: :service do
  describe "Retrieves weather information from http://api.weatherapi.com/v1/", :vcr do

    before do
      location = "thornton,co"
      service = WeatherService.new(location)
      @weather = service.get_weather
    end
    
    it "can retrieve location information" do
      location_info = @weather[:location]

      expect(location_info[:name]).to be_a(String)
      expect(location_info[:name]).to eq("Thornton")
      
      expect(location_info[:region]).to be_a(String)
      expect(location_info[:region]).to eq("Colorado")

      expect(location_info[:country]).to be_a(String)
      expect(location_info[:country]).to eq("United States of America")
      
      expect(location_info[:lat]).to be_a(Float)
      expect(location_info[:lat]).to eq(39.87)
      
      expect(location_info[:lon]).to be_a(Float)
      expect(location_info[:lon]).to eq(-104.97)
      
      expect(location_info[:tz_id]).to be_a(String)
      expect(location_info[:tz_id]).to eq("America/Denver")
      
      expect(location_info[:localtime_epoch]).to be_a(Integer)
      expect(location_info[:localtime]).to be_a(String)
    end

    it "can retrieve current weather information" do
      current_info = @weather[:current]
      
      expect(current_info[:last_updated_epoch]).to be_a(Integer)
      expect(current_info[:last_updated]).to be_a(String)
      expect(current_info[:temp_c]).to be_a(Float)
      expect(current_info[:temp_f]).to be_a(Float)
      expect(current_info[:is_day]).to be_a(Integer)
      expect(current_info[:condition][:text]).to be_a(String)
      expect(current_info[:condition][:icon]).to be_a(String)
      expect(current_info[:condition][:code]).to be_a(Integer)
      
      expect(current_info[:wind_mph]).to be_a(Float)
      expect(current_info[:wind_kph]).to be_a(Float)
      expect(current_info[:wind_degree]).to be_a(Integer)
      expect(current_info[:wind_dir]).to be_a(String)
      expect(current_info[:pressure_mb]).to be_a(Float)
      expect(current_info[:pressure_in]).to be_a(Float)
      expect(current_info[:humidity]).to be_a(Integer)
      expect(current_info[:cloud]).to be_a(Integer)
      expect(current_info[:feelslike_c]).to be_a(Float)
      expect(current_info[:feelslike_f]).to be_a(Float)
      expect(current_info[:vis_km]).to be_a(Float)
      expect(current_info[:vis_miles]).to be_a(Float)
      expect(current_info[:uv]).to be_a(Float)
      expect(current_info[:gust_mph]).to be_a(Float)
      expect(current_info[:gust_kph]).to be_a(Float)
    end

    it "can retrieve forecast weather information" do
      forecast = @weather[:forecast][:forecastday].first
      
      expect(forecast[:date]).to be_a(String)
      expect(forecast[:day][:maxtemp_c]).to be_a(Float)
      expect(forecast[:day][:maxtemp_f]).to be_a(Float)
      expect(forecast[:day][:mintemp_c]).to be_a(Float)
      expect(forecast[:day][:mintemp_f]).to be_a(Float)
      expect(forecast[:day][:avgtemp_c]).to be_a(Float)
      expect(forecast[:day][:avgtemp_f]).to be_a(Float)
      expect(forecast[:day][:maxwind_mph]).to be_a(Float)
      expect(forecast[:day][:maxwind_kph]).to be_a(Float)
      expect(forecast[:day][:totalprecip_mm]).to be_a(Float)
      expect(forecast[:day][:totalprecip_in]).to be_a(Float)
      expect(forecast[:day][:totalsnow_cm]).to be_a(Float)
      expect(forecast[:day][:avgvis_km]).to be_a(Float)
      expect(forecast[:day][:avgvis_miles]).to be_a(Float)
      expect(forecast[:day][:avghumidity]).to be_a(Float)
      expect(forecast[:day][:daily_will_it_rain]).to be_a(Integer)
      expect(forecast[:day][:daily_chance_of_rain]).to be_a(Integer)
      expect(forecast[:day][:daily_will_it_snow]).to be_a(Integer)
      expect(forecast[:day][:condition][:text]).to be_a(String)
      expect(forecast[:day][:condition][:icon]).to be_a(String)
      expect(forecast[:day][:condition][:code]).to be_a(Integer)
      expect(forecast[:day][:uv]).to be_a(Float)
      
      expect(forecast[:astro][:sunrise]).to be_a(String)
      expect(forecast[:astro][:sunset]).to be_a(String)
      expect(forecast[:astro][:moonrise]).to be_a(String)
      expect(forecast[:astro][:moonset]).to be_a(String)
      expect(forecast[:astro][:moon_phase]).to be_a(String)
      expect(forecast[:astro][:moon_illumination]).to be_a(String)
      expect(forecast[:astro][:is_moon_up]).to be_a(Integer)
      expect(forecast[:astro][:is_moon_up]).to be_a(Integer)
      expect(forecast[:astro][:is_sun_up]).to be_a(Integer)
    end
  end
end