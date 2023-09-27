class RoadtripFacade
  attr_reader :roadtrip

  def initialize(params)
    travel_params = {origin: params[:origin], destination: params[:destination]}
    @roadtrip = get_roadtrip_object(travel_params)
  end
  
  def get_roadtrip_object(travel_params)
    travel_times = get_travel_times(travel_params)
    travel_time_seconds = travel_times[:seconds]
    travel_time_formatted = travel_times[:formatted]

    if travel_time_seconds > 0
      eta_datetime = calculate_eta(travel_time_seconds)
      
      weather_params = {
        destination: travel_params[:destination], 
        travel_time_seconds: travel_time_seconds, 
        eta_datetime: eta_datetime
      }
      weather_at_eta = get_weather_at_eta(weather_params)
    else
      weather_at_eta = {}
    end
    
    roadtrip_params = {
      start_city: travel_params[:origin],
      end_city: travel_params[:destination], 
      travel_time: travel_time_formatted,
      weather_at_eta: weather_at_eta
    }
    Roadtrip.new(roadtrip_params)
  end
  
  def get_travel_times(travel_params)
    destination = MapquestService.new(travel_params[:destination])
    trip = destination.get_route(travel_params)
    
    if trip[:route][:routeError]
      travel_time_seconds = 0
      travel_time_formatted = "impossible"
    else
      travel_time_seconds = trip[:route][:time]
      travel_time_formatted = trip[:route][:formattedTime]
    end

    time_info = {
      seconds: travel_time_seconds, 
      formatted: travel_time_formatted 
    }
  end
  
  def calculate_eta(travel_time_seconds)
    current_time = Time.now
    eta_seconds = current_time + travel_time_seconds
    eta_datetime = eta_seconds.strftime('%Y-%m-%d %H:%M')
    
    return eta_datetime
  end
  
  def get_weather_at_eta(weather_params)
    days = 10
    weather_forecast = WeatherService.new(location: weather_params[:destination], days: days).get_weather
    weather_days = weather_forecast[:forecast][:forecastday]
    conditions_at_datetime = get_eta_hour_info(weather_days, weather_params[:eta_datetime])
  end
  
  def get_eta_hour_info(weather_days, eta_datetime)
    target_day = eta_datetime[0, 10]
    target_datetime = flatten_minutes(eta_datetime)
    
    one_day = weather_days.find do |day|
      day[:date] == target_day
    end
    one_hour = one_day[:hour].find do |hour|
      hour[:time] == target_datetime
    end
    
    condition = one_hour[:condition][:text]
    temperature = one_hour[:temp_f]
    
    conditions_at_datetime = {
      datetime: eta_datetime,
      temperature: temperature,
      condition: condition + "... with a chance of meatballs"
    }
  end

  def flatten_minutes(eta_datetime)
    cut_datetime = eta_datetime[0..-3]
    new_datetime = cut_datetime + "00"
  end

end