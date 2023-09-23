class Weather
  attr_reader :location, :current

  def initialize(params)
    @location = params[:location] if params[:location]
    @current = params[:current] if params[:current]
  end
end