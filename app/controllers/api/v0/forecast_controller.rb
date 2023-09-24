class Api::V0::ForecastController < ApplicationController
  def index
    if !params[:location]
      render json: ErrorSerializer.format_errors("Invalid parameters"), status: 400
    else
      begin
        weather_report = WeatherFacade.new(forecast_params[:location]).weather
        render json: WeatherSerializer.new(weather_report)
      rescue
        render json: ErrorSerializer.format_errors("Information not found"), status: 404
      end
    end
  end

  private

  def forecast_params
    params.permit(:location)
  end
end