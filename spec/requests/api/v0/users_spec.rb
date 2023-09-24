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
        expect(reply[:data][:attributes][:api-key]).to be_a String
      end
    end
  end
end