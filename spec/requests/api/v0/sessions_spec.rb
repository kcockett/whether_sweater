require "rails_helper"

RSpec.describe "Sessions API" do
  describe "POST /api/v0/sessions" do
    it "Logging in with valid credentials renders a json response with user id, email, and api key" do
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
        expect(reply[:data][:id]).to eq(user.id.to_s)

        expect(reply[:data]).to have_key(:attributes)
        expect(reply[:data][:attributes]).to be_a Hash
        
        expect(reply[:data][:attributes]).to have_key(:email)
        expect(reply[:data][:attributes][:email]).to eq(user.email)
        
        expect(reply[:data][:attributes]).to have_key(:api_key)
        expect(reply[:data][:attributes][:api_key]).to eq(user.api_key)
    end

    describe "SAD PATHS:  User tries to login with missing or incorrect information" do

      before do
        @user = User.create!(email: "user@example.com", password: "password")
      end

      it "Logging in with missing email renders a json response with an 'Invalid parameters' error" do
        
        json_payload = {
          # email: @user.email,
          password: "password"
        }.to_json
  
        post '/api/v0/sessions',
          params: json_payload,
          headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        reply = JSON.parse(response.body, symbolize_names: true)
  
        expect(response.status).to eq(401)
        expect(reply).to have_key(:errors)
        expect(reply[:errors]).to be_a Array
        expect(reply[:errors].first).to have_key(:detail)
        expect(reply[:errors].first[:detail]).to eq("Invalid credentials")
      end

      it "Logging in with missing password renders a json response with an 'Invalid parameters' error" do
        
        json_payload = {
          email: @user.email,
          # password: "password"
        }.to_json
  
        post '/api/v0/sessions',
          params: json_payload,
          headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        reply = JSON.parse(response.body, symbolize_names: true)
  
        expect(response.status).to eq(401)
        expect(reply).to have_key(:errors)
        expect(reply[:errors]).to be_a Array
        expect(reply[:errors].first).to have_key(:detail)
        expect(reply[:errors].first[:detail]).to eq("Invalid credentials")
      end

      it "Logging in with incorrect email renders a json response with an 'Invalid parameters' error" do
        
        json_payload = {
          email: "wrong_email@example.com",
          password: "password"
        }.to_json
  
        post '/api/v0/sessions',
          params: json_payload,
          headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        reply = JSON.parse(response.body, symbolize_names: true)
  
        expect(response.status).to eq(401)
        expect(reply).to have_key(:errors)
        expect(reply[:errors]).to be_a Array
        expect(reply[:errors].first).to have_key(:detail)
        expect(reply[:errors].first[:detail]).to eq("Invalid credentials")
      end

      it "Logging in with incorrect password renders a json response with an 'Invalid parameters' error" do
        
        json_payload = {
          email: @user.email,
          password: "wrong_password"
        }.to_json
  
        post '/api/v0/sessions',
          params: json_payload,
          headers: {
            'Content-Type' => 'application/json',
            'Accept' => 'application/json'
          }
        reply = JSON.parse(response.body, symbolize_names: true)
  
        expect(response.status).to eq(401)
        expect(reply).to have_key(:errors)
        expect(reply[:errors]).to be_a Array
        expect(reply[:errors].first).to have_key(:detail)
        expect(reply[:errors].first[:detail]).to eq("Invalid credentials")
      end
    end
  end

end