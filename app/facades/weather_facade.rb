class WeatherFacade
  attr_reader :location, :weather

  def initialize(location)
    latitude = MapquestService.new(location).location[:results].first[:locations].first[:latLng][:lat]
    longitude = MapquestService.new(location).location[:results].first[:locations].first[:latLng][:lng]
    @location = "#{latitude},#{longitude}"
    @weather = get_weather
  end

  def get_weather
    service = WeatherService.new(@location)
    weather_info = service.get_weather
    Weather.new(weather_info)
  end
end