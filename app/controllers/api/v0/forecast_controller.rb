class Api::V0::ForecastController < ApplicationController
  def index
    if !params[:location]
      render json: ErrorSerializer.format_errors("Invalid parameters"), status: 400
    else
      weather_report = WeatherFacade.new(forecast_params[:location]).weather
      render json: WeatherSerializer.new(weather_report)
    end
  end

  private

  def forecast_params
    params.permit(:location)
  end
end