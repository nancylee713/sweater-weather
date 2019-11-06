require 'rails_helper'

RSpec.describe Location do
  before(:each) do
    json_data = {
      "results": [
        "address_components": [
          { "long_name": "Denver", "types": [ "locality", "political"] },
          { "long_name": "Denver County", "types": ["administrative_area_level_2", "political"] },
          { "long_name": "Colorado", "short_name": "CO", "types": ["administrative_area_level_1", "political"] },
          { "long_name": "United States", "types": ["country", "political"] }
        ],
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

  it "can return address" do
    expected = {
      city: 'Denver',
      state: 'Colorado',
      country: 'United States'
    }

    expect(@location.address).to eq(expected)
  end

  it "can return formatted address" do
    expected = "Denver, Colorado, United States"

    expect(@location.formatted_address).to eq(expected)
  end
end
