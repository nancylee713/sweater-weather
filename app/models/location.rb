class Location
  attr_reader :latitude, :longitude, :address

  def initialize(data)
    @latitude = data[:results][0][:geometry][:location][:lat]
    @longitude = data[:results][0][:geometry][:location][:lng]
    @address = parse_address(data)
  end

  def formatted_address
    address.values.join(', ')
  end

  private

  def parse_address(data)
    city = data[:results][0][:address_components][0][:long_name]
    state = data[:results][0][:address_components][2][:short_name] unless data[:results][0][:address_components][2].nil?
    country = data[:results][0][:address_components][3][:long_name] unless data[:results][0][:address_components][3].nil?
    
    {
      city: city,
      state: state,
      country: country
    }
  end
end
