class ForecastFacade

  def initialize(data)
    arr = data.split(',')
    @city = arr[0]
    @state = arr[1]
  end

  def forecast_data
    Forecast.new(location, weather_data)
  end

  private
  attr_reader :city, :state

  def geocoding_data
    GoogleGeocodingService.get_location(city: city, state: state)
  end

  def location
    Location.new(geocoding_data)
  end

  def weather_data
    DarkSkyService.get_data(location)
  end
end
