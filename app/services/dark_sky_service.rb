class DarkSkyService
  def self.get_data(location)
    new.get_data(location)
  end

  def get_data(location)
    lat = location.latitude
    lng = location.longitude

    response = conn.get "#{lat},#{lng}"

    json = JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    key = ENV['dark_sky_api']
    Faraday.new(:url => "https://api.darksky.net/forecast/#{key}/") do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end
end
