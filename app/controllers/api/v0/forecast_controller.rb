class Api::V0::ForecastController < ApplicationController
  def index
    weather_report = WeatherFacade.new(forecast_params[:location]).weather
    render json: WeatherSerializer.new(weather_report)
  end

  private

  def forecast_params
    params.permit(:location)
  end
end