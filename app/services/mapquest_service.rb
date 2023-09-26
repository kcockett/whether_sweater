class MapquestService
  attr_reader :location

  def initialize(location)
    @location = get_location_info(location)
  end

  def get_location_info(location)
    params = { outFormat: "json", location: location }
    get_url("geocoding/v1/address", params)
  end

  def get_route(travel_params)
    params = { outFormat: "json", 
      from: travel_params[:origin], 
      to: travel_params[:destination] 
    }
    get_url("directions/v2/route", params)
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