class WeatherFacade
  attr_reader :location, :weather

  def initialize(location)
    default_forecast_days = 5
    service = MapquestService.new(location)
    latitude = service.location[:results].first[:locations].first[:latLng][:lat]
    longitude = service.location[:results].first[:locations].first[:latLng][:lng]
    search_coords = "#{latitude},#{longitude}"
    @weather = get_weather(search_coords, default_forecast_days)
  end
  
  def get_weather(location_coords,days)
    service = WeatherService.new(location_coords, days)
    weather_info = service.get_weather
    Weather.new(weather_info, location_coords)
  end
end