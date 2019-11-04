class Api::V1::BackgroundController < ApplicationController
  def show
    location = params[:location]

    # Get data from Unsplash Api
    image_data = UnsplashService.get_data(location)
  end
end
