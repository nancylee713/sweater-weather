require 'rails_helper'

describe 'Forecast API' do
  before(:each) do
    VCR.turn_off!
    stub_forecast_request
  end

  it 'sends forecast data' do
  it 'sends forecast data in US' do
    stub_denver_forecast_request

    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data][:attributes].count).to eq(5)
    expect(parsed[:data][:attributes][:overview]).to have_key(:location)
    expect(parsed[:data][:attributes][:overview][:location]).to eq("Denver, CO, United States")
    expect(parsed[:data][:attributes][:overview]).to have_key(:current_time)
    expect(parsed[:data][:attributes][:overview]).to have_key(:current_summary)
    expect(parsed[:data][:attributes][:overview]).to have_key(:icon)
    expect(parsed[:data][:attributes][:overview]).to have_key(:temp)
    expect(parsed[:data][:attributes][:overview]).to have_key(:temp_high)
    expect(parsed[:data][:attributes][:overview]).to have_key(:temp_low)

    expect(parsed[:data][:attributes][:details]).to have_key(:feels_like)
    expect(parsed[:data][:attributes][:details]).to have_key(:humidity)
    expect(parsed[:data][:attributes][:details]).to have_key(:visibility)
    expect(parsed[:data][:attributes][:details]).to have_key(:uvIndex)
    expect(parsed[:data][:attributes][:details]).to have_key(:summaries)

    expect(parsed[:data][:attributes][:hourly_forecast].count).to eq(8)
    expect(parsed[:data][:attributes][:hourly_forecast].first).to have_key(:time)
    expect(parsed[:data][:attributes][:hourly_forecast].first).to have_key(:temperature)

    expect(parsed[:data][:attributes][:daily_forecast].count).to eq(5)
    expect(parsed[:data][:attributes][:daily_forecast].first).to have_key(:summary)
    expect(parsed[:data][:attributes][:daily_forecast].first).to have_key(:precipProbability)
    expect(parsed[:data][:attributes][:daily_forecast].first).to have_key(:precipType)
    expect(parsed[:data][:attributes][:daily_forecast].first).to have_key(:temperatureHigh)
    expect(parsed[:data][:attributes][:daily_forecast].first).to have_key(:temperatureLow)
  end

  it "sends international forecast data" do
    stub_seoul_forecast_request

    get '/api/v1/forecast?location=seoul'

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data][:attributes].count).to eq(5)
    expect(parsed[:data][:attributes][:overview][:location]).to eq("Seoul, Seoul, South Korea")
  end
end
