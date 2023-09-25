class LibraryService 
  attr_reader :book_list

  def initialize(params)
    @book_list = find_books(params)
  end

  def find_books(params)
    params = { q: params[:location], limit: params[:limit] }
    get_url("search.json", params)
  end

  def get_url(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(
      url: "https://openlibrary.org/",
      headers: {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
    )
  end
end