require 'rails_helper'

RSpec.describe Forecast do
  before(:each) do
    location_data = {
      "results": [
        "address_components": [
          { "long_name": "Denver" },
          { "long_name": "Denver County" },
          { "short_name": "CO" },
          { "long_name": "United States" }
        ],
        "geometry": {
          "location": {
             "lat": 39.7392358,
             "lng": -104.990251
          }
        }
      ]
    }

    location = Location.new(location_data)

    weather_data = {
      :latitude => 39.7392358,
      :longitude => -104.990251,
      :currently => {
        :time => 1572817477,
        :summary=>"Mostly Cloudy",
        :icon=>"partly-cloudy-day",
        :temperature=>57.02
      },
      :daily => {
        :data => [
          :temperatureHigh => 56.39,
          :temperatureLow => 27.73
        ]
      },
      :hourly => {
        :data => [
          {
            :time => 1572793200,  # Today
            :summary => "Mostly cloudy until afternoon",
            :apparentTemperature => 54.21,
            :humidity => 0.29,
            :visibility => 10,
            :uvIndex => 1
          },
          {
            :time => 1572814800,  # Tonight
            :summary => "Partly cloudy starting tonight, continuing until tomorrow morning"
          }
        ]
      }
    }

    @forecast = Forecast.new(location, weather_data)
  end

  it "is created with weather data" do
    expect(@forecast).to be_a(Forecast)
  end

  it "can return specific attributes" do
    expect(@forecast.id).to eq(0)
    expect(@forecast.location).to eq('Denver, CO, United States')
    expect(@forecast.current_time).to eq('02:44 PM, 11/03')
    expect(@forecast.current_sum).to eq('Mostly Cloudy')
    expect(@forecast.icon).to eq('partly-cloudy-day')
    expect(@forecast.current_temp).to eq(57.02)
    expect(@forecast.temp_high).to eq(56.39)
    expect(@forecast.temp_low).to eq(27.73)
    expect(@forecast.feels_like).to eq(54.21)
    expect(@forecast.humidity).to eq(0.29)
    expect(@forecast.visibility).to eq(10)
    expect(@forecast.uvIndex).to eq(1)
    expect(@forecast.today_sum).to eq('Mostly cloudy until afternoon')
    expect(@forecast.tonight_sum).to eq('Partly cloudy starting tonight, continuing until tomorrow morning')
  end
end
