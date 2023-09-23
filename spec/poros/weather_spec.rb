require "rails_helper"

RSpec.describe "Weather", :vcr, type: :poro do
  describe "#initialize" do
    describe "should initialize" do

      before do
        location = {:name=>"Thornton",
          :region=>"Colorado",
          :country=>"United States of America",
          :lat=>39.87,
          :lon=>-104.97,
          :tz_id=>"America/Denver",
          :localtime_epoch=>1695483377,
          :localtime=>"2023-09-23 9:36"}
        
        current_weather = {:last_updated_epoch=>1695483000,
          :last_updated=>"2023-09-23 09:30",
          :temp_c=>17.0,
          :temp_f=>62.6,
          :is_day=>1,
          :condition=>
           {:text=>"Partly cloudy",
            :icon=>"//cdn.weatherapi.com/weather/64x64/day/116.png",
            :code=>1003},
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
          :gust_kph=>11.5}

        params = {location: location, current: current_weather}

        @object = Weather.new(params)
      end

      it "should initialze with current weather information" do
        expect(@object).to be_a Weather
        expect(@object.location).to be_a Hash
        expect(@object.current).to be_a Hash

        expect(@object.location[:name]).to eq("Thornton")
        expect(@object.location[:state]).to eq("Colorado")
        expect(@object.location[:country]).to eq("United States of America")
        expect(@object.location[:lat]).to eq(39.87)
        expect(@object.location[:lon]).to eq(-104.97)
        expect(@object.location[:time_zone]).to eq("America/Denver")
        expect(@object.location[:localtime]).to eq("2023-09-23 9:36")

        expect(@object.current[:last_updated]).to eq("2023-09-23 09:30")
        expect(@object.current[:temp]).to eq(62.6)
        expect(@object.current[:feels_like]).to eq(62.6)
        expect(@object.current[:humidity]).to eq(17)
        expect(@object.current[:uvi]).to eq(3.0)
        expect(@object.current[:visibility]).to eq(9.0)
        expect(@object.current[:condition]).to eq("Partly cloudy")
        expect(@object.current[:icon]).to eq("//cdn.weatherapi.com/weather/64x64/day/116.png")
      end

      it "should filter out unneeded attributes" do
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

        expect(@object.location[:localtime_epoch]).to be nil
      end
    end
  end
end