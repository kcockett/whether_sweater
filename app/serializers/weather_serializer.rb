class WeatherSerializer
  include JSONAPI::Serializer
  set_id :null_id do
    nil
  end
  set_type "forecast"
  attributes :current_weather, :daily_weather
end
