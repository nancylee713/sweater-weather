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

    
  end
end
