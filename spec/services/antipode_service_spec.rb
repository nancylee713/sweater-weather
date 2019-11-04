require 'rails_helper'

RSpec.describe AntipodeService do
  before(:each) do
    VCR.turn_off!
    WebMock.allow_net_connect!
  end

  it "can get latitude and longitude of an antipode city" do
    json_data = AntipodeService.get_data(lat: 22.3193039, lng: 114.1693611)

    expect(json_data).to be_a(Hash)
    expect(json_data).to have_key(:data)
    expect(json_data[:data][:type]).to eq('antipode')
    expect(json_data[:data][:attributes]).to have_key(:lat)
    expect(json_data[:data][:attributes]).to have_key(:long)
  end
end
