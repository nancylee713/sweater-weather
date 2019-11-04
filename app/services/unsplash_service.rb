class UnsplashService
  def self.get_data(location)
    new.get_data(location)
  end

  def get_data(location)
    response = Faraday.get "https://api.unsplash.com/search/photos/" do |req|
      req.headers['Accept-Version'] = 'v1'
      req.headers['Authorization'] = "Client-ID #{ENV['unsplash_access_key']}"
      req.params[:query] = location
    end

    json = JSON.parse(response.body, symbolize_names: true)
  end
end
