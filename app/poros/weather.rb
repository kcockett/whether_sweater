class Weather
  attr_reader :location, :current, :forecast

  def initialize(params, coordinates)
    if coordinates
      latitude_str, longitude_str = coordinates.split(',')
      latitude = latitude_str.to_f
      longitude = longitude_str.to_f
      @location = { 
        lat: latitude,
        lon: longitude
      }
    end

    if params[:current]
      @current = {
        last_updated: params[:current][:last_updated],
        temp: params[:current][:temp_f],
        feels_like: params[:current][:feelslike_f],
        humidity: params[:current][:humidity],
        uvi: params[:current][:uv],
        visibility: params[:current][:vis_miles],
        condition: params[:current][:condition][:text],
        icon: params[:current][:condition][:icon]
      }
    end

    if params[:forecast]
      @forecast = []
      params[:forecast][:forecastday].each do |day|
        info = {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon],
        hourly: get_hourly_data(day[:hour])
        }
        @forecast << info
      end
    end
  end

  def get_hourly_data(hours)
    data = []
    hours.each do |hour|
      info = {
        time: hour[:time][-5..-1], 
        temp: hour[:temp_f],
        condition: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
      data << info
    end
    data
  end
end