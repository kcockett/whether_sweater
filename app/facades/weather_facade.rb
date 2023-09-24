class WeatherFacade
  attr_reader :location, :weather

  def initialize(location)
    latitude = MapquestService.new(location).location[:results].first[:locations].first[:latLng][:lat]
    longitude = MapquestService.new(location).location[:results].first[:locations].first[:latLng][:lng]
    search_coords = "#{latitude},#{longitude}"
    @weather = get_weather(search_coords)
  end
  
  def get_weather(location_coords)
    service = WeatherService.new(location_coords)
    weather_info = service.get_weather
    Weather.new(weather_info, location_coords)
  end
end