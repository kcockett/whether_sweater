class DestinationBooks
  attr_reader

  def initialize(book_info)
    @destination = book_info[:docs].first[:title]
    @forecast = get_weather(@destination)
    @total_books_found = book_info[:numFound]
    @books = sort_books(book_info)
  end

  def get_weather(location)
    facade = WeatherFacade.new(location)
    summary = facade.weather.current_weather[:condition]
    temperature = "#{facade.weather.current_weather[:temperature]} F"
    require 'pry'; binding.pry
  end

  def sort_books(books)
    #
  end
end