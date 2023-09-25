require "rails_helper"

RSpec.describe "Library Service", type: :service do
  describe "Retrieves location information from https://openlibrary.rog/search.json?q=[title]&limit=[max number returned]", :vcr do

    before do
      @location = "Denver, Colorado"
      @limit = 3
      params = {q: @location, limit: @limit}
      service = LibraryService.new(params)
      @book_info = service.book_list
    end

    it "can retrieve the requested number of books for a given location" do
      expect(response.status).to eq 200
      expect(@book_info).to be_a Hash
      expect(@book_info).to have_key(:numFound)
      expect(@book_info[:numFound]).to be_a Integer
      
      expect(@book_info).to have_key(:docs)
      expect(@book_info[:docs]).to be_a Array
      expect(@book_info[:docs].count).to be_a eq(@limit)

      expect(@book_info[:docs].first).to have_key(:title)
      expect(@book_info[:docs].first[:title]).to be_a String

      expect(@book_info[:docs].first).to have_key(:isbn)
      expect(@book_info[:docs].first[:isbn]).to be_a Array
    end
  end
end