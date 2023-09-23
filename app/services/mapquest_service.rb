class MapquestService
  attr_reader :location

  def initialize(location)
    @location = location
    @lat_lon = get_lat_lon
  end

  def get_lat_lon
    params = { outFormat: "json", location: @location }
    get_url("geocoding/v1/address", params)
  end

  def get_url(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(
      url: "http://www.mapquestapi.com/",
      params: { key: Rails.application.credentials[:mapquest_api_key] },
      headers: {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
    )
  end
end