class Api::V1::BookSearchController < ApplicationController
  def index
    # require 'pry'; binding.pry
  end

  private

  def search_params
    params.permit(:location, :quantity)
  end
end