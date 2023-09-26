require "rails_helper"

RSpec.describe "Roadtrip API", type: :request do
  describe "POST /api/v0/road_trip", :vcr do
    
    describe "Happy path:  A properly formatted request returns a json response including:" do

      before do
        @user_1 = User.create!(email: "user_1@example.com", password: "password")
        @user_2 = User.create!(email: "user_2@example.com", password: "password")
        @json_payload = {
          origin: "Cincinatti,OH",
          destination: "Chicago,IL",
          api_key: @user_2.api_key.to_s
        }
  
        post '/api/v0/roadtrip',
          params: @json_payload.to_json,
          headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        @reply = JSON.parse(response.body, symbolize_names: true)
      end
      
      it "a data attribute, under which all other attributes are present" do
        expect(@reply).to have_key(:data)
        expect(@reply[:data]).to be_a Hash
      end
      
      it "id, always set to null" do
        expect(@reply[:data]).to have_key(:id)
        expect(@reply[:data][:id]).to eq("null")
      end
      
      it "type, always set to “roadtrip”" do
        expect(@reply[:data]).to have_key(:type)
        expect(@reply[:data][:type]).to eq("road_trip")
      end
      
      it "attributes, an object containing road trip information" do
        expect(@reply[:data]).to have_key(:attributes)
        expect(@reply[:data][:attributes]).to be_a Hash
      end
        
      
      it "start_city, string, such as “Cincinatti, OH”" do
        expect(@reply[:data][:attributes]).to have_key(:start_city)
        expect(@reply[:data][:attributes][:start_city]).to eq(@json_payload[:origin])
      end
      
      it "end_city, string, such as “Chicaco, IL”" do
        expect(@reply[:data][:attributes]).to have_key(:end_city)
        expect(@reply[:data][:attributes][:end_city]).to eq(@json_payload[:destination])
      end
      
      
      it "travel_time, string, something user-friendly like “2 hours, 13 minutes” or “2h13m” or “02:13:00”. Set this string to “impossible route” if there is no route between your cities" do
        expect(@reply[:data][:attributes]).to have_key(:travel_time)
        expect(@reply[:data][:attributes][:travel_time]).to be_a String
      end
      
      it "weather_at_eta, conditions at end_city when you arrive, object containing:" do
        expect(@reply[:data][:attributes]).to have_key(:weather_at_eta)
        expect(@reply[:data][:attributes][:weather_at_eta]).to be_a Hash
      end
      
      it "datetime, date and time for the reported weather at the destination at the approximate hour of arrival" do
        expect(@reply[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
        expect(@reply[:data][:attributes][:weather_at_eta][:datetime]).to be_a String
      end
      
      it "temperature, numeric value in Fahrenheit" do
        expect(@reply[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(@reply[:data][:attributes][:weather_at_eta][:temperature]).to be_a Float
      end
      
      it "condition, the text description for the weather condition at that hour.  note: this object will be blank if the travel time is impossible" do
        expect(@reply[:data][:attributes][:weather_at_eta]).to have_key(:condition)
        expect(@reply[:data][:attributes][:weather_at_eta][:condition]).to be_a String
      end
    end

    describe "Sad path tests" do

      it "cannot retrieve forcast for more than 10 days ahead [Weather API limitation]" do
        user_1 = User.create!(email: "user_1@example.com", password: "password")
        json_payload = {
          origin: "Cincinatti,OH",
          destination: "Cancun, Mexico",
          api_key: user_1.api_key.to_s
        }
  
        post '/api/v0/roadtrip',
          params: json_payload.to_json,
          headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        reply = JSON.parse(response.body, symbolize_names: true)
        expect(reply[:data][:attributes][:weather_at_eta][:condition]).to eq("The arrival date is too far ahead to forecast the weather at this time.")
        expect(reply[:data][:attributes][:weather_at_eta][:temperature]).to eq(0.0)
      end
    end
  end
end