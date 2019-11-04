class Api::V1::AntipodeController < ApplicationController
  def show
    facade = ForecastFacade.new(params[:location])
    render json: ForecastSerializer.new(facade.data)
  end
end
