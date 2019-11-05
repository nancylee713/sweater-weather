require 'rails_helper'

RSpec.describe RoadTrip do
  before(:each) do
    forecast_data = {
      hourly: {
        summary: "Partly cloudy throughout the day.",
        data: [
          { temperature: 12.13 }
        ]
      }
    }

    duration = {:text=>"1 hour 48 mins", :value=>6450}
    @road_trip = RoadTrip.new(forecast_data, duration)
  end

  it 'is created with location' do
    expect(@road_trip).to be_a(RoadTrip)
  end

  it 'can return attributes' do
    expect(@road_trip.estimated_travel_time).to eq('1 hour 48 mins')
    expect(@road_trip.eta.class).to eq(String)  # depends on current time
    expect(@road_trip.temperature).to eq(12.13)
    expect(@road_trip.summary).to eq('Partly cloudy throughout the day.')
  end
end
