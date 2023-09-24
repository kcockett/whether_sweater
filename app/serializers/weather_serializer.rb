class WeatherSerializer
  include JSONAPI::Serializer
  set_id :null_id do
    nil
  end
  set_type "forecast"
  attributes :location, :current_weather, :forecast
end
