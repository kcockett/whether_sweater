require "rails_helper"

RSpec.describe "DestinationFacade", :vcr, type: :facade do

  before do
    @destination = "denver,co"
    @quantity = 5
    params = {destination: @destination, quantity: @quantity}
    @facade = DestinationFacade.new(params)
  end

  describe "#get_info" do
    it "returns books and forecast at destination" do
      expect(@facade.destination).to eq(@destination)
      expect(@facade.total_books_found).to be_a Integer
      expect(@facade.forecast).to be_a Hash
      expect(@facade.forecast).to have_key(:summary)
      expect(@facade.forecast).to have_key(:temperature)
      expect(@facade.books).to be_a Array
      expect(@facade.books.count).to eq(@quantity)
      expect(@facade.books.first).to be_a Hash
      expect(@facade.books.first).to have_key(:isbn)
      expect(@facade.books.first[:isbn]).to be_a Array
      expect(@facade.books.first).to have_key(:title)
      expect(@facade.books.first[:title]).to be_a String
    end
  end
end