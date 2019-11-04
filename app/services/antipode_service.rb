class AntipodeService
  def self.get_data(lat:, lng:)
    new.get_data(lat, lng)
  end

  def get_data(lat, lng)
    response = Faraday.get "http://amypode.herokuapp.com/api/v1/antipodes" do |req|
      req.params['lat'] = lat
      req.params['long'] = lng
      req.headers['api_key'] = ENV['antipode_api_key']
    end

    json = JSON.parse(response.body, symbolize_names: true)
  end

end
