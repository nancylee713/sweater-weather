class Api::V1::BackgroundController < ApplicationController
  def show
    facade = BackgroundImageFacade.new(params[:location])
    render json: BackgroundImageSerializer.new(facade.img_data)
  end
end
