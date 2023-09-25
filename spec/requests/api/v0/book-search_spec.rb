require "rails_helper"

RSpec.describe "Book-Search API", type: :request do
  describe "GET /api/v0/book-search", :vcr do
    describe "when making a valid request (GET /api/v1/book-search?location=denver,co&quantity=5), the response should return a specific set of data in JSON format" do
      
      before do
        @location = "denver,co"
        @quantity = 5
        get "/api/v0/book-search?location=#{@location}&&quantity=#{@quantity}"
        @response = JSON.parse(response.body, symbolize_names: true)
      end

      it "response includes a data attribute, under which all other attributes are present" do
        expect(@response).to have_key(:data)
      end

      it "the :id is always set to null" do
        expect(@response[:data][:id]).to eq("null")
      end
      
      it "the :type is always set to books" do
        expect(@response[:data][:type]).to eq("books")
      end
      
      it "the :attributes contain a hash including :destination as a string matching the location" do
        expect(@response[:data][:attributes]).to be_a Hash
        expect(@response[:data][:attributes]).to have_key (:destination)
        expect(@response[:data][:attributes][:destination]).to eq(@location)
      end
      
      it "the :attributes contain a hash including :total_books_found as an integer" do
        expect(@response[:data][:attributes]).to have_key (:total_books_found)
        expect(@response[:data][:attributes][:total_books_found]).to be_a Integer
      end
      
      it "the :attributes contain a hash including :books as an array of books" do
        expect(@response[:data][:attributes]).to have_key (:books)
        expect(@response[:data][:attributes][:books]).to be_a Array
      end

      it "the :books array contain book information including :isbn as an array and :title as a string" do
        expect(@response[:data][:attributes]).to have_key (:books)
        expect(@response[:data][:attributes][:books]).to be_a Array
      end
    end
  end
end