require 'rails_helper'

RSpec.describe ReverseGeocodingService do
  before(:each) do
    VCR.turn_off!
    WebMock.allow_net_connect!
  end

  it "can get latitude and longitude of a given city" do
    json_data = ReverseGeocodingService.get_location(latlng: '-22.3193039, -65.8306389')

    expect(json_data).to be_a(Hash)
    expect(json_data).to have_key(:results)
    expect(json_data[:results].first).to have_key(:address_components)
    expect(json_data[:results].first).to have_key(:formatted_address)
  end
end
