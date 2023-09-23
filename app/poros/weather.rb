class Weather
  attr_reader :location, :current

  def initialize(params)
    if params[:location]
      @location = { 
        name: params[:location][:name],
        state: params[:location][:region],
        country: params[:location][:country],
        lat: params[:location][:lat],
        lon: params[:location][:lon],
        time_zone: params[:location][:tz_id],
        localtime: params[:location][:localtime]
      }
    end
    if params[:current]
      @current = {
        last_updated: params[:current][:last_updated],
        temp: params[:current][:temp_f],
        feels_like: params[:current][:feelslike_f],
        humidity: params[:current][:humidity],
        uvi: params[:current][:uv],
        visibility: params[:current][:vis_miles],
        condition: params[:current][:condition][:text],
        icon: params[:current][:condition][:icon]
      }
    end
  end
end