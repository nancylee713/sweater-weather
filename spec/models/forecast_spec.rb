require 'rails_helper'

RSpec.describe Forecast do
  before(:each) do
    geocoding_data = JSON.parse(stub_geocoding_request.response.body, symbolize_names: true)
    geocoding_data = JSON.parse(stub_denver_geocoding_request.response.body, symbolize_names: true)
    location = Location.new(geocoding_data)

    weather_data = JSON.parse(stub_darksky_request.response.body, symbolize_names: true)
    weather_data = JSON.parse(stub_denver_darksky_request.response.body, symbolize_names: true)
    @forecast = Forecast.new(location, weather_data)
  end

  it "is created with weather data" do
    expect(@forecast).to be_a(Forecast)
  end

  it "can return specific attributes" do
    expect(@forecast.id).to eq(0)
    expect(@forecast.location).to eq('Denver, CO, United States')
    expect(@forecast.current_time).to eq('03:55 PM, 11/02')
    expect(@forecast.current_sum).to eq('Partly Cloudy')
    expect(@forecast.icon).to eq('partly-cloudy-day')
    expect(@forecast.current_temp).to eq(45.55)
    expect(@forecast.temp_high).to eq(51.75)
    expect(@forecast.temp_low).to eq(27.56)
    expect(@forecast.feels_like).to eq(43.67)
    expect(@forecast.humidity).to eq(0.41)
    expect(@forecast.visibility).to eq(10)
    expect(@forecast.uvIndex).to eq(2)
    expect(@forecast.today_sum).to eq('Partly Cloudy')
    expect(@forecast.tonight_sum).to eq('Partly Cloudy')
    expect(@forecast.time).to eq(1572731759)
    expect(@forecast.hourly_forecast.count).to eq(8)
    expect(@forecast.daily_forecast.count).to eq(5)
  end
end
