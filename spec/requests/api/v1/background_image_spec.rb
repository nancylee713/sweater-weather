require 'rails_helper'

describe 'Forecast API' do
  before(:each) do
    VCR.turn_off!
    WebMock.allow_net_connect!
  end

  it 'sends forecast data' do
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed).to have_key(:data)
    expect(parsed[:data][:type]).to eq('background_image')
    expect(parsed[:data][:attributes]).to have_key(:url)
  end
end
