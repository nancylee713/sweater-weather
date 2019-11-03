class Api::V1::ForecastController < ApplicationController
  def index
    location = params[:location].split(',')
    city = location[0]
    state = location[1]

    geocoding_data = GoogleGeocodingService.get_location(city: city, state: state)
    location = Location.new(geocoding_data)
    weather_data = DarkSkyService.get_data(location)
    forecast_data = Forecast.new(location, weather_data)
    render json: ForecastSerializer.new(forecast_data)
  end
end
