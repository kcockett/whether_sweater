class WeatherFacade
  attr_reader

  def initialize(location)
    @location = location
  end

  def current_weather
    service = WeatherService.new(@location)
    weather_info = service.get_current_weather
    require 'pry'; binding.pry
    Weather.new(weather_info)
  end
end