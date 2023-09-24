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

        expect(response.status).to eq(201)
      end
    end
  end
end