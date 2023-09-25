require "rails_helper"

RSpec.describe "BooksList", :vcr, type: :poro do
  describe "#initialize" do

    before do
      @location = "Denver, Colorado"
      @limit = 4
      params = {location: @location, limit: @limit}
      @service = LibraryService.new(params)
      @book_info = @service.book_list
    end

    it "should initialize" do
      object = DestinationBooks.new(@book_info)
      require 'pry'; binding.pry

      expect(object).to be_a DestinationBooks
      expect(object.destination).to be_a String
      expect(object.destination).to eq(@location)

      expect(object.forecast).to be_a Hash
      expect(object.forecast).to have_key(:summary)
      expect(object.forecast[:summary]).to be_a String
      expect(object.forecast).to have_key(:temperature)
      expect(object.forecast[:temperature]).to be_a String
      
      expect(object.total_books_found).to be_a Integer

      expect(object.books).to be_a Array
      expect(object.books.count).to eq(@limit)
      expect(object.books.first).to be_a Hash
      expect(object.books.first).to have_key(:isbn)
      expect(object.books.first[:isbn]).to be_a Array
      expect(object.books.first[:isbn].first).to be_a String
      
      expect(object.books.first).to have_key(:title)
      expect(object.books.first[:title]).to be_a String
    end
  end
end