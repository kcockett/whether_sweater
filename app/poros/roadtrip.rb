class Roadtrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(params)
    @start_city = params[:start_city]
    @end_city = params[:end_city]
    @travel_time = params[:travel_time]
    @weather_at_eta = params[:weather_at_eta]
  end
end