class AntipodeLocation
  attr_reader :latitude, :longitude

  def initialize(data)
    @latitude = data[:data][:attributes][:lat]
    @longitude= data[:data][:attributes][:long]
  end

  def formatted_address
    return_city
  end

  private

  def latlng
    "#{latitude},#{longitude}"
  end

  def reverse_geocoding
    ReverseGeocodingService.get_location(latlng: latlng)
  end

  def return_city
    reverse_geocoding[:results].first[:address_components].third[:long_name]
  end
end
