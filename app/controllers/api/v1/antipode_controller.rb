class Api::V1::AntipodeController < ApplicationController
  def show
    # Find lat and lng for HK
    city = params[:location]
    geocoding_data = GoogleGeocodingService.get_location(city: city)
    location = Location.new(geocoding_data)
    lat = location.latitude
    lng = location.longitude
    # Find antipode lat and lng
    antipode_data = AntipodeService.get_data(lat: lat, lng: lng)
    antipode_location = AntipodeLocation.new(antipode_data)
    
    # Find current weather info for antipode
    weather_data = DarkSkyService.get_data(antipode_location)
    forecast_data = Forecast.new(antipode_location, weather_data)

    # Return data including city name thru reverse lookup
    render json: ForecastSerializer.new(forecast_data)
  end
end
