class Api::V1::RoadTripController < ApplicationController
  def show
    if valid_key
      facade = RoadTripFacade.new(trip_params)
      render json: RoadTripSerializer.new(facade.road_trip_data)

    else
      render_401
    end
  end

  private

  def trip_params
    params.permit(:origin, :destination, :api_key)
  end

  def valid_key
    valid_key? trip_params[:api_key]
  end

  def render_401
    render json: {
      error: "Invalid key. Please try again.",
      status: 401
    }, status: 401
  end
end
