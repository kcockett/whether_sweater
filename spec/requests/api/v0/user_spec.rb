require "rails_helper"

RSpec.describe "Users API", type: :request do
  describe "POST /api/v0/users", :vcr do
    
    describe "when making a valid request (POST /api/v0/users), the response should return a specific set of data in JSON format" do
      it "should return a status of 201" do
        json_payload = {
          email: "my_email@example.com",
          password: "password",
          password_confirmation: "password"
        }.to_json

        post '/api/v0/users',
          params: json_payload,
          headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        reply = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(201)
        expect(reply).to have_key(:data)
        expect(reply[:data]).to have_key(:type)
        expect(reply[:data][:type]).to eq("users")

        expect(reply[:data]).to have_key(:id)
        expect(reply[:data][:id]).to be_a String

        expect(reply[:data]).to have_key(:attributes)
        expect(reply[:data][:attributes]).to be_a Hash
        
        expect(reply[:data][:attributes]).to have_key(:email)
        expect(reply[:data][:attributes][:email]).to eq("my_email@example.com")
        
        expect(reply[:data][:attributes]).to have_key(:api_key)
        expect(reply[:data][:attributes][:api_key]).to be_a String
      end
    end

    describe "SAD PATHS: Invalid information returns errors" do

      it "should return a 422 error if no information is passed" do
        json_payload = {
          # email: "my_email@example.com",
          # password: "password",
          # password_confirmation: "password"
        }.to_json

        post '/api/v0/users',
          params: json_payload,
          headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        reply = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(422)
        expect(reply).to have_key(:errors)
        expect(reply[:errors]).to be_a Array
        expect(reply[:errors].first).to have_key(:details)
        expect(reply[:errors].first[:details]).to eq("Invalid parameters")
      end

      it "should return a 422 error if email is missing" do
        json_payload = {
          # email: "my_email@example.com",
          password: "password",
          password_confirmation: "password"
        }.to_json

        post '/api/v0/users',
          params: json_payload,
          headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        reply = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(422)
        expect(reply).to have_key(:errors)
        expect(reply[:errors]).to be_a Array
        expect(reply[:errors].first).to have_key(:details)
        expect(reply[:errors].first[:details]).to eq("Invalid parameters")
      end

      it "should return a 422 error if password is missing" do
        json_payload = {
          email: "my_email@example.com",
          # password: "password",
          password_confirmation: "password"
        }.to_json

        post '/api/v0/users',
          params: json_payload,
          headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        reply = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(422)
        expect(reply).to have_key(:errors)
        expect(reply[:errors]).to be_a Array
        expect(reply[:errors].first).to have_key(:details)
        expect(reply[:errors].first[:details]).to eq("Invalid parameters")
      end

      it "should return a 422 error if password_confirmation is missing" do
        json_payload = {
          email: "my_email@example.com",
          password: "password",
          # password_confirmation: "password"
        }.to_json

        post '/api/v0/users',
          params: json_payload,
          headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        reply = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(422)
        expect(reply).to have_key(:errors)
        expect(reply[:errors]).to be_a Array
        expect(reply[:errors].first).to have_key(:details)
        expect(reply[:errors].first[:details]).to eq("Invalid parameters")
      end

      it "should return a 422 error if passwords do not match" do
        json_payload = {
          email: "my_email@example.com",
          password: "password",
          password_confirmation: "wrong_password"
        }.to_json

        post '/api/v0/users',
          params: json_payload,
          headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        reply = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(422)
        expect(reply).to have_key(:errors)
        expect(reply[:errors]).to be_a Array
        expect(reply[:errors].first).to have_key(:details)
        expect(reply[:errors].first[:details]).to eq("Invalid parameters")
      end
    end
  end
end