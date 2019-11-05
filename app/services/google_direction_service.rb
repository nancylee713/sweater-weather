class GoogleDirectionService
  attr_reader :origin, :destination

  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def get_direction
    response = conn.get
    parsed_data = JSON.parse(response.body, symbolize_names: true)
    parsed_data[:routes].first[:legs].first
  end

  private

  def conn
    Faraday.new(
      url: 'https://maps.googleapis.com/maps/api/directions/json',
      params: {
        'origin' => origin,
        'destination' => destination,
        'key' => ENV["google_direction_key"]
      }
    )
  end
end
