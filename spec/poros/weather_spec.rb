require "rails_helper"

RSpec.describe "Weather", :vcr, type: :poro do
  describe "#initialize" do
    describe "should initialize" do

      before do

        location = {
          :name=>"Thornton",
          :region=>"Colorado",
          :country=>"United States of America",
          :lat=>39.87,
          :lon=>-104.97,
          :tz_id=>"America/Denver",
          :localtime_epoch=>1695483377,
          :localtime=>"2023-09-23 9:36"
        }
        
        current_weather = {
          :last_updated_epoch=>1695483000,
          :last_updated=>"2023-09-23 09:30",
          :temp_c=>17.0,
          :temp_f=>62.6,
          :is_day=>1,
          :condition=> {
            :text=>"Partly cloudy",
            :icon=>"//cdn.weatherapi.com/weather/64x64/day/116.png",
            :code=>1003
          },
          :wind_mph=>25.5,
          :wind_kph=>41.0,
          :wind_degree=>240,
          :wind_dir=>"WSW",
          :pressure_mb=>1018.0,
          :pressure_in=>30.05,
          :precip_mm=>0.0,
          :precip_in=>0.0,
          :humidity=>17,
          :cloud=>50,
          :feelslike_c=>17.0,
          :feelslike_f=>62.6,
          :vis_km=>16.0,
          :vis_miles=>9.0,
          :uv=>3.0,
          :gust_mph=>7.1,
          :gust_kph=>11.5
        }

        day = {
          forecastday: [
            {   
              "date": "2023-09-23",
              "date_epoch": 1695427200,
              "day": {
                "maxtemp_c": 24.4,
                "maxtemp_f": 75.9,
                "mintemp_c": 9.0,
                "mintemp_f": 48.2,
                "avgtemp_c": 16.6,
                "avgtemp_f": 61.8,
                "maxwind_mph": 12.3,
                "maxwind_kph": 19.8,
                "totalprecip_mm": 0.0,
                "totalprecip_in": 0.0,
                "totalsnow_cm": 0.0,
                "avgvis_km": 10.0,
                "avgvis_miles": 6.0,
                "avghumidity": 33.0,
                "daily_will_it_rain": 0,
                "daily_chance_of_rain": 0,
                "daily_will_it_snow": 0,
                "daily_chance_of_snow": 0,
                "uv": 4.0,
                "condition": {
                  "text": "Overcast",
                  "icon": "//cdn.weatherapi.com/weather/64x64/day/122.png",
                  "code": 1009
                },
              },
              "astro": {
                "sunrise": "06:48 AM",
                "sunset": "06:55 PM",
                "moonrise": "03:42 PM",
                "moonset": "No moonset",
                "moon_phase": "Waxing Gibbous",
                "moon_illumination": "52",
                "is_moon_up": 1,
                "is_sun_up": 1
              }
            }
          ]
        }
        params = {location: location, current: current_weather, forecast: day}

        @object = Weather.new(params)
      end

      it "should initialze with location information" do
        expect(@object).to be_a Weather
        expect(@object.location).to be_a Hash

        expect(@object.location[:name]).to eq("Thornton")
        expect(@object.location[:state]).to eq("Colorado")
        expect(@object.location[:country]).to eq("United States of America")
        expect(@object.location[:lat]).to eq(39.87)
        expect(@object.location[:lon]).to eq(-104.97)
        expect(@object.location[:time_zone]).to eq("America/Denver")
        expect(@object.location[:localtime]).to eq("2023-09-23 9:36")
      end

      it "should initialze with current weather information" do
        expect(@object).to be_a Weather
        expect(@object.current).to be_a Hash

        expect(@object.current[:last_updated]).to eq("2023-09-23 09:30")
        expect(@object.current[:temp]).to eq(62.6)
        expect(@object.current[:feels_like]).to eq(62.6)
        expect(@object.current[:humidity]).to eq(17)
        expect(@object.current[:uvi]).to eq(3.0)
        expect(@object.current[:visibility]).to eq(9.0)
        expect(@object.current[:condition]).to eq("Partly cloudy")
        expect(@object.current[:icon]).to eq("//cdn.weatherapi.com/weather/64x64/day/116.png")
      end
      
      it "should initialize with weather forecast information" do
        expect(@object.forecast).to be_a Array
        expect(@object.forecast.first).to be_a Hash

        info = @object.forecast.first
  
        expect(info[:date]).to eq("2023-09-23")
        expect(info[:sunrise]).to eq("06:48 AM")
        expect(info[:sunset]).to eq("06:55 PM")
        expect(info[:max_temp]).to eq(75.9)
        expect(info[:min_temp]).to eq(48.2)
        expect(info[:condition]).to eq("Overcast")
        expect(info[:icon]).to eq("//cdn.weatherapi.com/weather/64x64/day/122.png")
      end

      it "should filter out unnecessary location attributes" do
        expect(@object.location[:localtime_epoch]).to be nil
      end

      it "should filter out unnecessary current weather attributes" do
        expect(@object.current[:last_updated_epoch]).to be nil
        expect(@object.current[:temp_c]).to be nil
        expect(@object.current[:wind_kph]).to be nil
        expect(@object.current[:pressure_mb]).to be nil
        expect(@object.current[:precip_mm]).to be nil
        expect(@object.current[:precip_in]).to be nil
        expect(@object.current[:cloud]).to be nil
        expect(@object.current[:feelslike_c]).to be nil
        expect(@object.current[:vis_km]).to be nil
        expect(@object.current[:gust_mph]).to be nil
        expect(@object.current[:gust_kph]).to be nil
      end

      it "should filter out unnecessary forecast attributes" do
        expect(@object.forecast.first[:date_epoch]).to be nil
        expect(@object.forecast.first[:day][:maxtemp_c]).to be nil
        expect(@object.forecast.first[:day][:mintemp_c]).to be nil
        expect(@object.forecast.first[:day][:avgtemp_c]).to be nil
        expect(@object.forecast.first[:day][:maxwind_kph]).to be nil
        expect(@object.forecast.first[:day][:totalprecip_mm]).to be nil
        expect(@object.forecast.first[:day][:totalsnow_cm]).to be nil
        expect(@object.forecast.first[:day][:avgvis_km]).to be nil
        expect(@object.forecast.first[:day][:vis_km]).to be nil
        expect(@object.forecast.first[:day][:daily_will_it_rain]).to be nil
        expect(@object.forecast.first[:day][:daily_chance_of_rain]).to be nil
        expect(@object.forecast.first[:day][:daily_will_it_snow]).to be nil
        expect(@object.forecast.first[:day][:daily_chance_of_snow]).to be nil
        expect(@object.forecast.first[:day][:condition][:code]).to be nil
        expect(@object.forecast.first[:day][:uv]).to be nil
        expect(@object.forecast.first[:astro][:moonrise]).to be nil
        expect(@object.forecast.first[:astro][:moonset]).to be nil
        expect(@object.forecast.first[:astro][:moon_phase]).to be nil
        expect(@object.forecast.first[:astro][:moon_illumination]).to be nil
        expect(@object.forecast.first[:astro][:is_moon_up]).to be nil
        expect(@object.forecast.first[:astro][:is_sun_up]).to be nil
      end
    end
  end
end