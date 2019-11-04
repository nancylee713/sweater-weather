class ForecastFacade
  def initialize(city)
    @city = city
  end

  def data
    Forecast.new(antipode_location, darksky_data)
  end

  private

  def google_geocoding_data
    GoogleGeocodingService.get_location(city: @city)
  end

  def location
    Location.new(google_geocoding_data)
  end

  def antipode_data
    AntipodeService.get_data(lat: location.latitude, lng: location.longitude)
  end

  def antipode_location
    AntipodeLocation.new(antipode_data)
  end

  def darksky_data
    DarkSkyService.get_data(antipode_location)
  end
end
