class Api::V0::RoadtripController < ApplicationController
  def create
    if !roadtrip_params[:origin] || !roadtrip_params[:destination] || !roadtrip_params[:api_key]
      render json: ErrorSerializer.format_errors("Missing parameters"), status: 400
    else
      if !User.find_by(api_key: roadtrip_params[:api_key])
        render json: ErrorSerializer.format_errors("Invalid parameters"), status: 401
      else
        roadtrip = RoadtripFacade.new(roadtrip_params)
        render json: RoadtripSerializer.new(roadtrip), status: 200
      end
    end
  end

  private

  def roadtrip_params
    params.permit(:origin, :destination, :api_key)
  end
end