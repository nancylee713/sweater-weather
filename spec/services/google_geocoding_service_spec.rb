require 'rails_helper'

RSpec.describe GoogleGeocodingService do
  before(:each) do
    VCR.turn_off!
    WebMock.allow_net_connect!
  end

  it "can get latitude and longitude of a given city" do
    json_data = GoogleGeocodingService.get_location("Denver,CO")

    expect(json_data).to be_a(Hash)
    expect(json_data).to have_key(:results)
    geometry = json_data[:results].first[:geometry]
    expect(geometry).to have_key(:location)
    location = geometry[:location]
    expect(location).to have_key(:lat)
    expect(location).to have_key(:lng)
  end
end
