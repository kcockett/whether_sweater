class WeatherSerializer
  include JSONAPI::Serializer
  set_id "null"
  set_type "forecast"
  attributes :location, :current, :forecast
end
