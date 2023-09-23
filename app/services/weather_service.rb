class WeatherService

  def get_current_weather(location, air_quality_index? = true)
    get_url("current.json")
  end

  def conn
    Faraday.new(url: "http://api.weatherapi.com/v1/") do |faraday|
      faraday.params(key: Rails.application.credentials[WEATHER-API-KEY])
    end
  end
end