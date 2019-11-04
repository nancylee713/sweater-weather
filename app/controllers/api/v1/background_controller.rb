class Api::V1::BackgroundController < ApplicationController
  def show
    location = params[:location]

    raw_data = UnsplashService.get_data(location)
    img_data = Image.new(raw_data)
    render json: BackgroundImageSerializer.new(img_data)
  end
end
