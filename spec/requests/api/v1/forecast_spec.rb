require 'rails_helper'

describe 'Forecast API' do
  before(:each) do
    VCR.turn_off!
    WebMock.allow_net_connect!

    # json_response = File.open('./spec/fixtures/weather_data.json')
    # stub_request(:get,
    #   "https://api.darksky.net/forecast/#{ENV['dark_sky_api']}/39.7392358,-104.990251/?exclude=minutely,flags"
    # ).to_return(
    #   status: 200,
    #   body: json_response
    # )
  end

  it 'sends forecast data' do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data][:attributes][:location]).to eq("Denver, CO, United States")
    expect(parsed[:data][:attributes].count).to eq(13)
  end
end
