require "rails_helper"

RSpec.describe "Forecast API", type: :request do
  describe "GET /api/v0/forecast", :vcr do
    
    describe "when making a valid request (GET /api/v0/forecast?location=cincinatti,oh), the response should return a specific set of data in JSON format" do
      
      before do
        location = "cincinatti,oh"
        get "/api/v0/forecast?location=#{location}"
        @response = JSON.parse(response.body, symbolize_names: true)
      end
      
      it "response includes a data attribute, under which all other attributes are present" do

        expect(@response).to have_key(:data)
      end

      it "the ID is always set to null" do

        expect(@response[:data][:id]).to be_nil
      end

      it "type is always set to 'forecast'" do

        expect(@response[:data][:type]).to eq("forecast")
      end

      it "attributes is an object holding weather data" do

        expect(@response[:data]).to have_key(:attributes)
      end

      describe "the object holds 'current_weather' with current weather data" do

        it "has a key called 'current_weather" do

          expect(@response[:data][:attributes]).to have_key(:current_weather)
        end

        it "has key 'last_updated' with a value in a human-readable format such as '2023-04-07 16:30'" do
          expect(@response[:data][:attributes][:current_weather]).to have_key(:last_updated)
          value = @response[:data][:attributes][:current_weather][:last_updated]
          expected_format = /\d{4}-\d{2}-\d{2} \d{2}:\d{2}/
          expect(value).to match(expected_format)
        end
        
        it "temperature, floating point number indicating the current temperature in Fahrenheit" do
          
          expect(@response[:data][:attributes][:current_weather]).to have_key(:temperature)
          expect(@response[:data][:attributes][:current_weather][:temperature]).to be_a Float
        end
        
        it "feels_like, floating point number indicating a temperature in Fahrenheit" do
          
          expect(@response[:data][:attributes][:current_weather]).to have_key(:feels_like)
          expect(@response[:data][:attributes][:current_weather][:feels_like]).to be_a Float
        end
        
        it "humidity, numeric (int or float)" do
          
          expect(@response[:data][:attributes][:current_weather]).to have_key(:humidity)
          expect(@response[:data][:attributes][:current_weather][:humidity]).to be_a(Float).or be_a(Integer)
        end
        
        it "uvi, numeric (int or float)" do
          
          expect(@response[:data][:attributes][:current_weather]).to have_key(:uvi)
          expect(@response[:data][:attributes][:current_weather][:uvi]).to be_a(Float).or be_a(Integer)
        end
        
        it "visibility, numeric (int or float)" do
          
          expect(@response[:data][:attributes][:current_weather]).to have_key(:visibility)
          expect(@response[:data][:attributes][:current_weather][:visibility]).to be_a(Float).or be_a(Integer)
        end
        
        it "condition, the text description for the current weather condition" do
          
          expect(@response[:data][:attributes][:current_weather]).to have_key(:condition)
          expect(@response[:data][:attributes][:current_weather][:condition]).to be_a(String)
        end
        
        it "icon, png string for current weather condition" do
          
          expect(@response[:data][:attributes][:current_weather]).to have_key(:icon)
          expect(@response[:data][:attributes][:current_weather][:icon]).to be_a(String)
        end
      end
      
      describe "the object holds 'daily_weather' with weather data for the next 5 days with the following: " do
        
        it "should have key 'daily_weather' that is an array with 5 days of weather data" do
          expect(@response[:data][:attributes]).to have_key(:daily_weather)
          expect(@response[:data][:attributes][:daily_weather]).to be_a(Array)
          expect(@response[:data][:attributes][:daily_weather].count).to eq(5)
        end
        
        it "date, in a human-readable format such as '2023-04-07'" do
          
          expect(@response[:data][:attributes][:daily_weather].first).to have_key(:date)
          value = @response[:data][:attributes][:daily_weather].first[:date]
          expected_format = /\d{4}-\d{2}-\d{2}/
          expect(value).to match(expected_format)
        end
        
        it "sunrise, in a human-readable format such as '07:13 AM'" do
          expect(@response[:data][:attributes][:daily_weather].first).to have_key(:sunrise)
          value = @response[:data][:attributes][:daily_weather].first[:sunrise]
          expected_format = /\d{2}:\d{2} [APap][Mm]/
          expect(value).to match(expected_format)
        end
        
        it "sunset, in a human-readable format such as “08:07 PM”" do
          
          expect(@response[:data][:attributes][:daily_weather].first).to have_key(:sunset)
          value = @response[:data][:attributes][:daily_weather].first[:sunset]
          expected_format = /\d{2}:\d{2} [APap][Mm]/
          expect(value).to match(expected_format)
        end
        
        it "max_temp, floating point number indicating the maximum expected temperature in Fahrenheit" do

          expect(@response[:data][:attributes][:daily_weather].first).to have_key(:max_temp)
          expect(@response[:data][:attributes][:daily_weather].first[:max_temp]).to be_a Float
        end
        
        it "min_temp, floating point number indicating the minimum expected temperature in Fahrenheit" do
          
          expect(@response[:data][:attributes][:daily_weather].first).to have_key(:min_temp)
          expect(@response[:data][:attributes][:daily_weather].first[:min_temp]).to be_a Float
        end
        
        it "condition, the text description for the weather condition" do
          
          expect(@response[:data][:attributes][:daily_weather].first).to have_key(:condition)
          expect(@response[:data][:attributes][:daily_weather].first[:condition]).to be_a String
        end
        
        it "icon, png string for weather condition" do
          
          expect(@response[:data][:attributes][:daily_weather].first).to have_key(:icon)
          expect(@response[:data][:attributes][:daily_weather].first[:icon]).to be_a String
        end
      end
      
      describe "the object holds 'hourly_weather' which is an array of all 24 hour’s hour data for the current day, including:" do

        it "has key 'hourly_weather' which is an array of 24 items" do
          expect(@response[:data][:attributes][:daily_weather].first).to have_key(:hourly_weather)
          expect(@response[:data][:attributes][:daily_weather].first[:hourly_weather]).to be_a(Array)
          expect(@response[:data][:attributes][:daily_weather].first[:hourly_weather].count).to eq(24)
        end
        
        it "time, in a human-readable format such as “22:00”" do
          
          expect(@response[:data][:attributes][:daily_weather].first[:hourly_weather].first).to have_key(:time)
          value = @response[:data][:attributes][:daily_weather].first[:hourly_weather].first[:time]
          expected_format = /\d{2}:\d{2}/
          expect(value).to match(expected_format)
        end
        
        it "temperature, floating point number indicating the temperature in Fahrenheit for that hour" do
          
          expect(@response[:data][:attributes][:daily_weather].first[:hourly_weather].first).to have_key(:temperature)
          expect(@response[:data][:attributes][:daily_weather].first[:hourly_weather].first[:temperature]).to be_a Float
        end
        
        it "conditions, the text description for the weather condition at that hour" do
          
          expect(@response[:data][:attributes][:daily_weather].first[:hourly_weather].first).to have_key(:conditions)
          expect(@response[:data][:attributes][:daily_weather].first[:hourly_weather].first[:conditions]).to be_a String
        end
        
        it "icon, string, png string for weather condition at that hour" do
          
          expect(@response[:data][:attributes][:daily_weather].first[:hourly_weather].first).to have_key(:icon)
          expect(@response[:data][:attributes][:daily_weather].first[:hourly_weather].first[:icon]).to be_a String
        end

      end
    end

    describe "SAD PATH: returns an error when invalid information is provided" do
      it "returns an error if the location is missing" do
        get "/api/v0/forecast"
        reply = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(reply).to have_key(:errors)
        expect(reply[:errors]).to be_an Array
        expect(reply[:errors].first).to have_key(:detail)
        expect(reply[:errors].first[:detail]).to eq("Invalid parameters")
      end

      it "SAD PATH: returns results for Washington DC if the location is invalid" do
        location = "invalid location"
        get "/api/v0/forecast?location=#{location}"
        reply = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)
        expect(reply[:data][:attributes][:location][:lat]).to eq(38.89037)
        expect(reply[:data][:attributes][:location][:lon]).to eq(-77.03196)
      end
    end
  end
end