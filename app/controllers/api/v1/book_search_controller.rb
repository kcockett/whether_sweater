class Api::V1::BookSearchController < ApplicationController
  def index
    destination = DestinationFacade.new(search_params)
    render json: DestinationSerializer.new(destination.information)
  end

  private

  def search_params
    params.permit(:location, :quantity)
  end
end