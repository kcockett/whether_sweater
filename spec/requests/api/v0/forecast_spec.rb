require "rails_helper"

RSpec.describe "Forecast API", type: :request do
  describe "GET /api/v0/forecast", :vcr do
    
    scenario "when making a valid request (GET /api/v0/forecast?location=cincinatti,oh), the response should return a specific set of data in JSON format" do
      
      it "the ID is always set to null" 

      it "type is always set to 'forecast'"

      it "attributes is an object holding weather data" 

      scenario "the object holds 'current_weather' with current weather data" do

        it "last_updated, in a human-readable format such as '2023-04-07 16:30'"

        it "temperature, floating point number indicating the current temperature in Fahrenheit"

        it "feels_like, floating point number indicating a temperature in Fahrenheit"

        it "humidity, numeric (int or float)"

        it "uvi, numeric (int or float)"

        it "visibility, numeric (int or float)"

        it "condition, the text description for the current weather condition"

        it "icon, png string for current weather condition"

      end

      scenario "the object holds 'daily_weather' with weather data for the next 5 days with the following: " do

        it "date, in a human-readable format such as '2023-04-07'"

        it "sunrise, in a human-readable format such as '07:13 AM'"

        it "sunset, in a human-readable format such as “08:07 PM”"

        
      end

    end
  end
end