class DestinationFacade
  attr_reader :destination, :quantity, :information

  def initialize(params)
    @destination = params[:destination]
    @quantity = params[:quantity]
    @information = get_information
  end
  
  def get_information
    book_info = LibraryService.new(location: @destination, limit: @quantity).book_list
    DestinationBooks.new(book_info)
  end
end