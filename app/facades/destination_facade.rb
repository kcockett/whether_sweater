class DestinationFacade
  attr_reader 

  def initialize(params)
    @destination = params[:destination]
    @limit = params[:quantity]
    @information = get_information(params)
  end

  def get_information(params)
    
  end
end