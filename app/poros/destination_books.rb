class DestinationBooks
  attr_reader :destination, :forecast, :total_books_found, :books

  def initialize(book_info)
    @destination = book_info[:q]
    @forecast = get_weather(@destination)
    @total_books_found = book_info[:numFound]
    @books = sort_books(book_info)
  end

  def get_weather(location)
    facade = WeatherFacade.new(location)
    summary = facade.weather.current_weather[:condition]
    temperature = "#{facade.weather.current_weather[:temperature]} F"
    forecast = {summary: summary, temperature: temperature}
  end

  def sort_books(books)
    book_list = books[:docs]
    sorted_books = []
    book_list.each do |book|
      title = book[:title]
      isbn = book[:isbn] if book[:isbn]
      sorted_books << {title: title, isbn: isbn}
    end
    sorted_books
  end
end