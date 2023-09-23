require "rails_helper"

RSpec.describe "Forecast API", type: :request do
  describe "GET /api/v0/forecast", :vcr do
    
    describe "when making a valid request (GET /api/v0/forecast?location=cincinatti,oh), the response should return a specific set of data in JSON format" do
      
      before do
        @location = "cincinatti,oh"
        @response = get "/api/v0/forecast?location=#{@location}"
      end
      
      it "the ID is always set to null" do
        expect(@response[:id]).to eq("null")
      end

      it "type is always set to 'forecast'" do
        expect(@response[:type]).to eq("forecast")
      end

      it "attributes is an object holding weather data" do
        expect(@response[:attributes]).to be_a Weather
      end

      # scenario "the object holds 'current_weather' with current weather data" do

      #   it "last_updated, in a human-readable format such as '2023-04-07 16:30'"

      #   it "temperature, floating point number indicating the current temperature in Fahrenheit"

      #   it "feels_like, floating point number indicating a temperature in Fahrenheit"

      #   it "humidity, numeric (int or float)"

      #   it "uvi, numeric (int or float)"

      #   it "visibility, numeric (int or float)"

      #   it "condition, the text description for the current weather condition"

      #   it "icon, png string for current weather condition"

      # end
    end
    #   scenario "the object holds 'daily_weather' with weather data for the next 5 days with the following: " do

    #     it "date, in a human-readable format such as '2023-04-07'"

    #     it "sunrise, in a human-readable format such as '07:13 AM'"

    #     it "sunset, in a human-readable format such as “08:07 PM”"

    #     it "max_temp, floating point number indicating the maximum expected temperature in Fahrenheit"

    #     it "min_temp, floating point number indicating the minimum expected temperature in Fahrenheit"

    #     it "condition, the text description for the weather condition"

    #     it "icon, png string for weather condition"

    #   end

    #   scenario "the object holds 'hourly_weather' which is an array of all 24 hour’s hour data for the current day, including:" do

    #     it "time, in a human-readable format such as “22:00”"

    #     it "temperature, floating point number indicating the temperature in Fahrenheit for that hour"

    #     it "conditions, the text description for the weather condition at that hour"

    #     it "icon, string, png string for weather condition at that hour"

    #   end
    # end
  end
end