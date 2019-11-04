class AntipodeLocation
  attr_reader :latitude, :longitude

  def initialize(data)
    @latitude = data[:data][:attributes][:lat]
    @longitude= data[:data][:attributes][:long]
  end
end
