require 'rails_helper'

RSpec.describe Forecast do
  before(:each) do
    geocoding_data = JSON.parse(stub_denver_geocoding_request.response.body, symbolize_names: true)
    location = Location.new(geocoding_data)

    weather_data = JSON.parse(stub_denver_darksky_request.response.body, symbolize_names: true)
    @forecast = Forecast.new(location, weather_data)
  end

  it "is created with weather data" do
    expect(@forecast).to be_a(Forecast)
  end

  it "can return specific attributes" do
    expect(@forecast.id).to eq(0)
    expect(@forecast.location).to be_a(Location)
    expect(@forecast.current_time).to eq(1572731759)
    expect(@forecast.current_sum).to eq('Partly Cloudy')
    expect(@forecast.icon).to eq('partly-cloudy-day')
    expect(@forecast.current_temp).to eq(45.55)
    expect(@forecast.temp_high).to eq(51.75)
    expect(@forecast.temp_low).to eq(27.56)
    expect(@forecast.feels_like).to eq(43.67)
    expect(@forecast.humidity).to eq(0.41)
    expect(@forecast.visibility).to eq(10)
    expect(@forecast.uvIndex).to eq(2)
    expect(@forecast.today_summary).to eq('Partly Cloudy')
    expect(@forecast.hourly_time).to eq(1572728400)
    expect(@forecast.hourly_group.count).to eq(8)
    expect(@forecast.daily_group.count).to eq(5)
  end
end
