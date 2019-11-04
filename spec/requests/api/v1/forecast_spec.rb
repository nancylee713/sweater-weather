require 'rails_helper'

describe 'Forecast API' do
  before(:each) do
    VCR.turn_off!
    stub_forecast_request
  end

  it 'sends forecast data' do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data][:attributes][:location]).to eq("Denver, CO, United States")
    expect(parsed[:data][:attributes].count).to eq(13)
  end
end
