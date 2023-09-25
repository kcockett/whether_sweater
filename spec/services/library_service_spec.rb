require "rails_helper"

RSpec.describe "Open Library Service", type: :service do
  describe "Retrieves location information from https://openlibrary.rog/search.json?q=[title]&limit=[max number returned]", :vcr do

    before do
      params = {q: "Denver, Colorado", limit: 3}
      service = OpenLibraryService.new(params)
      @book_info = service.book_list
    end

    it "can retrieve the requested number of books for a given location" do
      expect(response.status).to eq 200
      expect(@book_info).to be_a Hash
      expect(@book_info).to have_key("numFound")
      expect(@book_info["numFound"]).to be_a Integer
      
      expect(@book_info).to have_key("docs")
      expect(@book_info["docs"]).to be_a Array
    end
  end
end