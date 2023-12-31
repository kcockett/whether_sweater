require "rails_helper"

RSpec.describe "Roadtrip API", type: :request do
  describe "POST /api/v0/road_trip", :vcr do
    
    describe "Happy path:  A properly formatted request returns a json response including:" do

      before do
        @user_1 = User.create!(email: "user_1@example.com", password: "password")
        @user_2 = User.create!(email: "user_2@example.com", password: "password")
        @json_payload = {
          # origin: "Cincinatti,OH",
          # destination: "Chicago,IL",
          origin: "New York, NY",
          destination: "Los Angeles, CA",
          api_key: @user_2.api_key.to_s
        }
  
        post '/api/v0/road_trip',
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

      it "will return a 400 error origin is missing" do
        user_1 = User.create!(email: "user_1@example.com", password: "password")
        json_payload = {
          # origin: "Cincinatti,OH",
          destination: "Chicago,IL",
          api_key: user_1.api_key.to_s
        }
  
        post '/api/v0/road_trip',
          params: json_payload.to_json,
          headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        reply = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 400
        expect(reply).to have_key(:errors)
        expect(reply[:errors]).to be_a Array
        expect(reply[:errors].first).to be_a Hash
        expect(reply[:errors].first).to have_key(:detail)
        expect(reply[:errors].first[:detail]).to eq("Missing parameters")
      end

      it "will return a 400 error destination is missing" do
        user_1 = User.create!(email: "user_1@example.com", password: "password")
        json_payload = {
          origin: "Cincinatti,OH",
          # destination: "Chicago,IL",
          api_key: user_1.api_key.to_s
        }
  
        post '/api/v0/road_trip',
          params: json_payload.to_json,
          headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        reply = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 400
        expect(reply).to have_key(:errors)
        expect(reply[:errors]).to be_a Array
        expect(reply[:errors].first).to be_a Hash
        expect(reply[:errors].first).to have_key(:detail)
        expect(reply[:errors].first[:detail]).to eq("Missing parameters")
      end

      it "will return a 401 error api_key is missing" do
        user_1 = User.create!(email: "user_1@example.com", password: "password")
        json_payload = {
          origin: "Cincinatti,OH",
          destination: "Chicago,IL",
          # api_key: user_1.api_key.to_s
        }
  
        post '/api/v0/road_trip',
          params: json_payload.to_json,
          headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        reply = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 401
        expect(reply).to have_key(:errors)
        expect(reply[:errors]).to be_a Array
        expect(reply[:errors].first).to be_a Hash
        expect(reply[:errors].first).to have_key(:detail)
        expect(reply[:errors].first[:detail]).to eq("Invalid parameters")
      end

      it "will return a 401 error if api-key does not match a user" do
        user_1 = User.create!(email: "user_1@example.com", password: "password")
        json_payload = {
          origin: "Cincinatti,OH",
          destination: "Chicago,IL",
          api_key: "incorrect_api_key"
        }
  
        post '/api/v0/road_trip',
          params: json_payload.to_json,
          headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        reply = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 401
        expect(reply).to have_key(:errors)
        expect(reply[:errors]).to be_a Array
        expect(reply[:errors].first).to be_a Hash
        expect(reply[:errors].first).to have_key(:detail)
        expect(reply[:errors].first[:detail]).to eq("Invalid parameters")
      end

      it "will return no error if the route cannot be plotted but weather will be empty and travel time will be impossible" do
        user_1 = User.create!(email: "user_1@example.com", password: "password")
        json_payload = {
          origin: "Cincinatti,OH",
          destination: "Honolulu,HI",
          api_key: user_1.api_key
        }
  
        post '/api/v0/road_trip',
          params: json_payload.to_json,
          headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        reply = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 200
        expect(reply).to have_key(:data)
        expect(reply[:data]).to have_key(:attributes)
        expect(reply[:data][:attributes]).to have_key(:travel_time)
        expect(reply[:data][:attributes][:travel_time]).to eq("impossible")
        expect(reply[:data][:attributes]).to have_key(:weather_at_eta)
        expect(reply[:data][:attributes][:weather_at_eta]).to eq({})
      end
    end
  end
end