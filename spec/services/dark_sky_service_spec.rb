require 'rails_helper'

RSpec.describe DarkSkyService do
  before(:each) do
    VCR.turn_off!
    stub_geocoding_request
    json_data = JSON.parse(stub_geocoding_request.response.body, symbolize_names: true)

    @location = Location.new(json_data)
  end

  it "can get latitude and longitude of a given city" do
    WebMock.allow_net_connect!

    json_data = DarkSkyService.get_data(@location)

    expect(json_data).to be_a(Hash)
    expect(json_data).to have_key(:latitude)
    expect(json_data).to have_key(:longitude)

    expect(json_data).to have_key(:currently)
    expect(json_data).to have_key(:daily)
    expect(json_data).to have_key(:hourly)

    currently = json_data[:currently]
    expect(currently).to have_key(:summary)
    expect(currently).to have_key(:icon)
    expect(currently).to have_key(:temperature)
    expect(currently).to have_key(:time)

    daily = json_data[:daily]
    expect(daily).to have_key(:data)
    expect(daily[:data].first).to have_key(:temperatureHigh)
    expect(daily[:data].first).to have_key(:temperatureLow)

    hourly = json_data[:hourly]
    expect(hourly).to have_key(:data)
    expect(hourly[:data].first).to have_key(:apparentTemperature)
    expect(hourly[:data].first).to have_key(:humidity)
    expect(hourly[:data].first).to have_key(:visibility)
    expect(hourly[:data].first).to have_key(:uvIndex)
    expect(hourly[:data].first).to have_key(:summary)
  end
end
