class ForecastFacade

  def initialize(place)
    @place = place
  end

  def forecast_data
    Forecast.new(location, weather_data)
  end

  private
  attr_reader :place

  def geocoding_data
    GoogleGeocodingService.get_location(place)
  end

  def location
    Location.new(geocoding_data)
  end

  def weather_data
    DarkSkyService.get_data(location)
  end
end
