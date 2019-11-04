class ReverseGeocodingService
  def self.get_location(latlng:)
    new.get_location(latlng)
  end

  def get_location(latlng)
    response = conn.get 'geocode/json', {
      latlng: latlng
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
