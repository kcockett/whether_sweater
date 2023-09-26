class Api::V0::RoadTripController < ApplicationController

  rescue_from NoRouteToDestinationError, with: :handle_no_route_to_destination

  def create
    if !roadtrip_params[:origin] || !roadtrip_params[:destination]
      render json: ErrorSerializer.format_errors("Missing parameters"), status: 400
    else
      if !User.find_by(api_key: roadtrip_params[:api_key]) || !roadtrip_params[:api_key]
        render json: ErrorSerializer.format_errors("Invalid parameters"), status: 401
      else
        roadtrip = RoadtripFacade.new(roadtrip_params)
        render json: RoadtripSerializer.new(roadtrip.roadtrip), status: 200
      end
    end
  end

  private

  def roadtrip_params
    params.permit(:origin, :destination, :api_key)
  end

  def handle_no_route_to_destination
    render json: ErrorSerializer.format_errors("No route to destination"), status: 603
  end
end