require "rails_helper"

RSpec.describe "DestinationFacade", :vcr, type: :facade do

  before do
    @location = "denver,co"
    @quantity = 5
    params = {location: @location, quantity: @quantity}
    @facade = DestinationFacade.new(params)
  end

  describe "#get_info" do
    it "returns books and forecast at destination" do
      expect(@facade.information.destination).to eq(@location)
      expect(@facade.information.total_books_found).to be_a Integer
      expect(@facade.information.forecast).to be_a Hash
      expect(@facade.information.forecast).to have_key(:summary)
      expect(@facade.information.forecast).to have_key(:temperature)
      expect(@facade.information.books).to be_a Array
      expect(@facade.information.books.count).to eq(@quantity)
      expect(@facade.information.books.first).to be_a Hash
      expect(@facade.information.books.first).to have_key(:isbn)
      expect(@facade.information.books.first[:isbn]).to be_a Array
      expect(@facade.information.books.first).to have_key(:title)
      expect(@facade.information.books.first[:title]).to be_a String
    end
  end
end