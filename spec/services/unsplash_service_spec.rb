require 'rails_helper'

RSpec.describe UnsplashService do
  before(:each) do
    VCR.turn_off!
    WebMock.allow_net_connect!
  end

  it "can get image url given a location" do
    json_data = UnsplashService.get_data('denver')

    expect(json_data).to be_a(Hash)
    expect(json_data).to have_key(:results)
    expect(json_data[:results].first).to have_key(:urls)
    expect(json_data[:results].first[:urls]).to have_key(:full)
  end
end
