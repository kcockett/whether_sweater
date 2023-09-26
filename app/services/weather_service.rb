class WeatherService
  attr_reader :location

  def initialize(location:, days:)
    @location = location
    @days = days
  end

  def get_weather
    params = { q: @location, days: @days }
    get_url("forecast.json", params)
  end

  def get_url(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(
      url: "http://api.weatherapi.com/v1/",
      params: { key: Rails.application.credentials[:weather_api_key] },
      headers: {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
    )
  end
  
end
