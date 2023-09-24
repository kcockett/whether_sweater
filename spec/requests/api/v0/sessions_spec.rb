require "rails_helper"

RSpec.describe "Sessions request" do
  describe "POST /api/v0/sessions" do
    describe "Logging in with valid credentials renders a json response with user id, email, and api key" do
      user = User.create!(email: "user@example.com", password: "password")
      
      json_payload = {
        email: "user@example.com",
        password: "password"
      }.to_json

      post '/api/v0/sessions',
        params: json_payload,
        headers: {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }
      reply = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
        expect(reply).to have_key(:data)
        expect(reply[:data]).to have_key(:type)
        expect(reply[:data][:type]).to eq("users")

        expect(reply[:data]).to have_key(:id)
        expect(reply[:data][:id]).to eq("1")

        expect(reply[:data]).to have_key(:attributes)
        expect(reply[:data][:attributes]).to be_a Hash
        
        expect(reply[:data][:attributes]).to have_key(:email)
        expect(reply[:data][:attributes][:email]).to eq(user.email)
        
        expect(reply[:data][:attributes]).to have_key(:api_key)
        expect(reply[:data][:attributes][:api_key]).to eq(user.api_key)
    end
  end

end