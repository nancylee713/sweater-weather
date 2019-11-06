class BackgroundImageFacade
  def initialize(location)
    @location = location
  end

  def img_data
    Image.new(unsplash_service)
  end

  private
  attr_reader :location
  
  def unsplash_service
    UnsplashService.get_data(location)
  end
end
