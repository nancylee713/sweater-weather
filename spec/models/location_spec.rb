require 'rails_helper'

RSpec.describe Location do
  before(:each) do
    json_data = {
      "results": [
        "geometry": {
          "location": {
             "lat": 39.7392358,
             "lng": -104.990251
          }
        }
      ]
    }

    @location = Location.new(json_data)
  end

  it 'is created with location' do
    expect(@location).to be_a(Location)
  end

  it "can return latitude" do
    expected = 39.7392358
    expect(@location.latitude).to eq(expected)
  end

  it "can return longitude" do
    expected = -104.990251
    expect(@location.longitude).to eq(expected)
  end
end
