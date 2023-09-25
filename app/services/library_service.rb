class LibraryService 

  def initialize(title, limit)
    @book_list = find_books(title, limit)
  end

  def find_books(title, limit)
    params = { q: title, limit: limit }
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