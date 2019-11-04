class DarkSkyService
  def self.get_data(location)
    new.get_data(location)
  end

  def get_data(location)
    key = ENV['dark_sky_api']
    lat = location.latitude
    lng = location.longitude

    response = Faraday.get "https://api.darksky.net/forecast/#{key}/#{lat},#{lng}" 

    json = JSON.parse(response.body, symbolize_names: true)
  end
end
