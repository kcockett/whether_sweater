class WeatherFacade
  attr_reader

  def initialize(location)
    @location = location
  end

  def get_weather
    service = WeatherService.new(@location)
    weather_info = service.get_weather
    Weather.new(weather_info)
  end
end