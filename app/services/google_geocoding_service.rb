class GoogleGeocodingService
  def self.get_location(city:, state:)
    new.get_location(city, state)
  end

  def get_location(city, state)
    response = conn.get 'geocode/json', {
      address: "#{city}, #{state}"
    }

    json = JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(:url => 'https://maps.googleapis.com/maps/api/') do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
      faraday.params["key"] = ENV['google_geocoding_api']
    end
  end
end
