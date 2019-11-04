class AntipodeService
  def self.get_data(lat:, lng:)
    new.get_data(lat, lng)
  end

  def get_data(lat, lng)
    response = conn.get do |req|
      req.params['lat'] = lat
      req.params['lng'] = lng
      req.headers['api_key'] = ENV['antipode_api_key']
    end

    json = JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(:url => "http://amypode.herokuapp.com/api/v1/antipodes/") do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end
end
