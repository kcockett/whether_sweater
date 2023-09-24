require "rails_helper"

RSpec.describe User, type: :model do

  before do
    @user1 = User.create!(email: "user1@example.com", password: "password")
    @user2 = User.create!(email: "user2@example.com", password: "password")
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
  end

  describe "methods" do
    describe "#generate_api_key"
    it "should generate an api key upon creation of a user" do
      expect(@user1.email).to eq("user1@example.com")
      expect(@user1.api_key).to_not be_nil
      expect(@user1.api_key).to_not eq(@user2.api_key)
    end
  end
end