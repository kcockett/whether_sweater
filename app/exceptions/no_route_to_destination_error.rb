class NoRouteToDestinationError < StandardError
  def initialize(message = "No route to destination")
    super(message)
  end
end
