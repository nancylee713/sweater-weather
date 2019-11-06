class Location
  attr_reader :latitude, :longitude, :address

  def initialize(data)
    @latitude = data[:results][0][:geometry][:location][:lat]
    @longitude = data[:results][0][:geometry][:location][:lng]
    @address = check_address(data)
  end

  def formatted_address
    address.values.reject(&:empty?).join(', ')
  end

  private

  def check_address(data)
    alt_address = { country: data[:results].first[:formatted_address] }
    parse_address(data).values.join.empty? ? alt_address : parse_address(data)
  end

  def parse_address(data)
    {
      city: name_of(data, 'locality'),
      state: name_of(data, 'administrative_area_level_1'),
      country: name_of(data, 'country')
    }
  end

  def name_of(data, type)
    temp = data[:results][0][:address_components]
            .select { |x| x[:types].include? type }
    temp.present? ? temp.first[:long_name] : ''
  end
end
