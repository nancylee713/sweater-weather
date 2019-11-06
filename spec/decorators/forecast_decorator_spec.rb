require 'rails_helper'

RSpec.describe ForecastDecorator do
  before(:each) do
    geocoding_data = JSON.parse(stub_denver_geocoding_request.response.body, symbolize_names: true)
    location = Location.new(geocoding_data)

    weather_data = JSON.parse(stub_denver_darksky_request.response.body, symbolize_names: true)
    raw_forecast = Forecast.new(location, weather_data)
    @forecast = ForecastDecorator.new(raw_forecast)
  end

  it "is created with raw forecast" do
    expect(@forecast).to be_a(ForecastDecorator)
  end

  it "can return formatted attributes" do
    expect(@forecast.address).to eq('Denver, Colorado, United States')
    expect(@forecast.current_time).to eq('03:55 PM, 11/02')
    expect(@forecast.summaries[:today_sum]).to eq('Partly Cloudy')
    expect(@forecast.summaries[:tonight_sum]).to eq('Partly Cloudy')

    expected_hours = @forecast.hourly_group.map {|x| x[:time]}
    actual_hours = ["3 PM", "4 PM", "5 PM", "6 PM", "7 PM", "8 PM", "9 PM", "10 PM"]
    expect(expected_hours).to eq(actual_hours)

    expected_days = @forecast.daily_group.map {|x| x[:time]}
    actual_days = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday"]
    expect(expected_days).to eq(actual_days)
  end
end
