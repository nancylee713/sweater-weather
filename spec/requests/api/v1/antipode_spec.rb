require 'rails_helper'

describe 'Antipode API' do
  before(:each) do
    VCR.turn_off!
    WebMock.allow_net_connect!
  end

  it 'sends forecast data' do
    get '/api/v1/antipode?location=hongkong'

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data][:type]).to eq("forecast")
    expect(parsed[:data][:attributes][:location]).to eq("Jujuy")
    expect(parsed[:data][:attributes].count).to eq(13)
  end
end
