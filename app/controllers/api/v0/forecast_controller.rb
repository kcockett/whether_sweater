class Api::V0::ForecastController < ApplicationController
  def index
    require 'pry'; binding.pry
    weather_report = WeatherFacade.new(forecast_params[:location])
    render json: WeatherSerializer.new(weather_report)
  end

  private

  def forecast_params
    params.permit(:location)
  end
end